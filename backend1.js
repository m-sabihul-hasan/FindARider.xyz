const http = require('http');
const express = require('express');
var cors = require('cors')
const bodyParser = require('body-parser');
const { stringify } = require('qs');
const socketio = require('socket.io');
// const multer = require('multer');
// const upload = multer({dest:__dirname + "/src/assets"});

var MongoClient = require('mongodb').MongoClient;
var url = 'mongodb://localhost:27017/';

const app = express();
const server = http.createServer(app);
const io = socketio(server,{
    cors: {
            origin: "*",
            methods: ["GET", "POST"],
            credentials: true,
            transports: ['websocket', 'polling'],
    },
    allowEIO3: true
    });
// const fs = require('fs');
app.use(cors());
app.use(bodyParser.json());

const PORT = process.env.PORT || 3000


let users = {};
let rides = {};
let rides_booked = {};
let chat = {};
var ride_count = 0;

// Fetch data from database to local cache
MongoClient.connect(url, function(err, db) {
    var dbo = db.db("application");

    dbo.collection("users").findOne({}, (err, res) => {
        delete res._id;
        users = res;
    });

    dbo.collection("rides").findOne({}, (err, res) => {
        delete res._id;
        rides = res;
        ride_count = Object.keys(rides).length;
    });

    dbo.collection("chat").findOne({}, (err, res) => {
        delete res._id;
        chat = res;
    });

    dbo.collection("rides_booked").findOne({}, (err, res) => {
        delete res._id;
        rides_booked = res;
    });
});

function update_users() {
    
    MongoClient.connect(url, function(err, db) {
        var dbo = db.db("application");
        dbo.collection("users").replaceOne({}, users);
    });

}

function update_rides() {

    MongoClient.connect(url, function(err, db) {
        var dbo = db.db("application");
        dbo.collection("rides").replaceOne({}, rides);
    });

}

function update_chat() {

    MongoClient.connect(url, function(err, db) {
        var dbo = db.db("application");
        dbo.collection("chat").replaceOne({}, chat);
    });

}

function update_rides_booked() {

    MongoClient.connect(url, function(err, db) {
        var dbo = db.db("application");
        dbo.collection("rides_booked").replaceOne({}, rides_booked);
    });

}


app.get('/', (req, res) => res.send('hello!'));

// Respond to signup request
app.post('/signup', (req, res, next) => {
    console.log(req.body);
    res.status(200);
    uniqueness = confirm_unique(req.body);
    res.send(JSON.stringify(uniqueness));
    if (uniqueness['mobile'] == false && uniqueness['username'] == false && uniqueness['email'] == false)
    {
        users[req.body['email']] = {name: req.body['name'], username: req.body['username'], mobile: req.body['mobile'], password: req.body['password']};
        update_users();
    }
    console.log(users)
});

// Check if user details are unique
function confirm_unique(user)
{
    error = {username: false, email: false, mobile: false};
    for (const property in users)
    {
        if (property == user.email) {
            error['email'] = true;
        }
        if (users[property]['username'] == user.username) {
            error['username'] = true;
        }
        if (users[property]['mobile'] == user.mobile) {
            error['mobile'] = true;
        }
    }
    return error;
}

// Confirm login credentials
app.post('/login', (req, res, next) => {
    res.status(200);

    if (req.body['email'] in users && users[req.body['email']]['password'] == req.body['password']) 
    {
        res.send(users[req.body['email']]['username']);
    }
    else
        res.send('false');
});

// Create a ride request by a driver
app.post('/createride', (req, res, next) => {
    res.status(200);
    ride_count += 1;
    trip_id = ride_count.toString();
    trip_id = (5-trip_id.length)*"0" + trip_id;
    rides[trip_id] = {};

    for (const property in req.body) {
        rides[trip_id][property] = req.body[property];
    }

    rides_booked[trip_id] = {};
    rides_booked[trip_id]["driver"] = req.body["driver"];

    for (var i = 0; i < 4; i++)
    {
        rides_booked[trip_id]["passenger"+i.toString()] = 'None';

    }
    chat[trip_id] = [];

    update_rides();
    update_rides_booked();
    update_chat();

    console.log(trip_id);

    res.send(trip_id);
});

// Send a list of active rides to passengers
app.post('/listrides', (req, res, next) => {
    res.status(200);

    let send_rides = rides;
    for (const property in send_rides)
    {
        if (send_rides[property]["space"] == '0')
            delete send_rides[property];
    }
    console.log(send_rides);

    res.send(send_rides);
});

roomsJoined = {};
connected_users = {};

io.on('connection', socket => {

    // Add users to trip chatroom
    socket.on('addToRoom', (trip_id) => {
        roomsJoined[socket.id] = trip_id;
        socket.join(trip_id);
    });

    socket.on('leaveRoom', (trip_id) => {
        socket.leave(trip_id);
    });

    console.log("connected", socket.id);

    socket.on('disconnect', () => {
        console.log("disconnected", socket.id);
        delete connected_users[socket.id];
    })

    // Store the socket id of the currently logged in users
    socket.on('username', username => {
        username = JSON.parse(username);
        console.log(username);
        connected_users[socket.id] = {};
        connected_users[socket.id]["username"] = username["username"];
        connected_users[socket.id]["userType"] = username["userType"];
        for(const property in rides) {
            if (rides[property]["driver"] == username["username"] || rides[property]["passenger1"] == username["username"] || rides[property]["passenger2"] == username["username"] || rides[property]["passenger3"] == username["username"] || rides[property]["passenger4"] == username["username"]) {
                // console.log(property);
                toSend = rides[property];
                toSend["tripID"] = property
                io.to(socket.id).emit('activeride',JSON.stringify(toSend));
            }
        }
    })

    // Send a booking request to the driver
    socket.on('bookingRequest', trip_id => {
        if (rides[trip_id]["space"] == 0)
            socket.emit('spaceFull', "");
        else {
            for(const property in connected_users) {
                if (connected_users[property]["username"] == rides[trip_id]["driver"]) {
                    io.to(property).emit('bookingRequestRecieve', connected_users[socket.id]["username"]);
                }
            }
        }
    })

    // Recieve the response of a booking request from the driver
    socket.on('bookingRequestResponse', response => {
        response = JSON.parse(response);
        console.log(response);
        if (response["res"] == "true")
        {
            for(const property in rides) {
                if (rides[property]["driver"] == connected_users[socket.id]["username"]) {
                    rides[property]["space"] -= 1;
                    io.in(property).emit("newPassenger")
                    if (rides[property]["passenger1"] == 'None')
                        p = "1";
                    else if (rides[property]["passenger2"] == 'None')
                        p = "2";
                    else if (rides[property]["passenger3"] == 'None')
                        p = "3";
                    else if (rides[property]["passenger4"] == 'None')
                        p = "4";

                    rides[property]["passenger"+p] = response["passenger"];
                    io.in(property).emit('addPassenger',p+response["passenger"]);
                    update_rides();
                }
            }

            for(const property in connected_users) {
                if (connected_users[property]["username"] == response["passenger"]) {
                    console.log(response["passenger"]);
                    io.to(property).emit('bookingRequestAccepted', "");
                }
            }
        }
    })
    
    // Request chat history
    socket.on('previousChatRequest', (useless) => {
        console.log("chat history request recieved");
        console.log(chat[roomsJoined[socket.id]])
        previousChat = [];
        trip = roomsJoined[socket.id];
        console.log(chat);
        console.log(roomsJoined);
        for(i in chat[trip]) {
            console.log("PUSHING");
            console.log(i);
            previousChat.push(JSON.stringify(chat[trip][i]));
        }
        console.log("being sent");
        console.log(previousChat);
        socket.emit('previousChat', previousChat.toString());
    });

    //Send message to the passengers/rider in the trip
    socket.on("message", message => {
        console.log(message, connected_users);
        io.in(roomsJoined[socket.id]).emit("recieveMessage", JSON.stringify({username: connected_users[socket.id]["username"], message: message, userType: connected_users[socket.id]["userType"]}));
        chat[roomsJoined[socket.id]].push({username: connected_users[socket.id]["username"], message: message, userType: connected_users[socket.id]["userType"]});
        update_chat();
    })
});

server.listen(PORT, () => {
    console.log("listening on *:" + PORT)
})