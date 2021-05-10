const http = require('http');
const express = require('express');
var cors = require('cors')
const bodyParser = require('body-parser');
const { stringify } = require('qs');
const socketio = require('socket.io');
// const multer = require('multer');
// const upload = multer({dest:__dirname + "/src/assets"});

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

users = {
            '1':{username:'1',mobile:'1',password:'1'},
            '2':{username:'2',mobile:'2',password:'2'}
        };

rides = {
    '01': {
      startLocation: "import 'package:flutter_app/Screens/ListRoutes/listroutes_screen.dart';",
      destination: "import 'package:flutter_app/Screens/ListRoutes/listroutes_screen.dart';",
      car: 'awewq4',
      licenseNumber: 'asdsare',
      space: '2',
      fare: '35',
      time: '23:08',
      date: '4/24',
      driver: 'asd',
      passenger1: 'None',
      passenger2: 'None',
      passenger3: 'None',
      passenger4: 'None'
    },
    '02': {
      startLocation: 'i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it ',
      destination: 'i like to move it move it i like to move it move it i like to move it move it i like to move it move it i like to move it move it not',
      car: 'Cultus',
      licenseNumber: 'weo9rpw',
      space: '1',
      fare: '2',
      time: '23:09',
      date: '4/24',
      driver: 'asd',
      passenger1: 'None',
      passenger2: 'None',
      passenger3: 'None',
      passenger4: 'None'
    }
    // '03': {
    //     startLocation: 'qwe',
    //     destination: 'asd',
    //     car: 'qweqwe',
    //     licenseNumber: '1212312',
    //     space: '2',
    //     fare: '23',
    //     time: '15:39',
    //     date: '4/26',
    //     driver: '1',
    //     passenger1: 'None',
    //     passenger2: 'None',
    //     passenger3: 'None',
    //     passenger4: 'None'
    //   }
  };
var ride_count = Object.keys(rides).length;

rides_booked = {};
chat = {'03': []};

app.get('/', (req, res) => res.send('hello!'));

app.post('/signup', (req, res, next) => {
    console.log(req.body);
    res.status(200);
    uniqueness = confirm_unique(req.body);
    res.send(JSON.stringify(uniqueness));
    if (uniqueness['mobile'] == false && uniqueness['username'] == false && uniqueness['email'] == false)
    {
        users[req.body['email']] = {name: req.body['name'], email: req.body['username'], mobile: req.body['mobile'], password: req.body['password']};   
    }
    console.log(users)
});

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

app.post('/login', (req, res, next) => {
    res.status(200);
    if (req.body['email'] in users && users[req.body['email']]['password'] == req.body['password']) 
    {
        // console.log(users.body['email']['username']);
        res.send(users[req.body['email']]['username']);
    }
    else
        res.send('false');
});

app.post('/createride', (req, res, next) => {
    res.status(200);
    // console.log(users.body['email']['username']);
    ride_count += 1;
    trip_id = ride_count.toString();
    trip_id = (5-trip_id.length)*"0" + trip_id;
    // console.log(req.body);
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
    console.log(trip_id);
    res.send(trip_id);
});

app.post('/listrides', (req, res, next) => {
    res.status(200);
    // console.log(users.body['email']['username']);
    // ride_count += 1;
    // trip_id = ride_count.toString();
    // trip_id = (5-trip_id.length)*"0" + trip_id;
    // console.log(req.body);
    // rides[trip_id] = {};
    // for (const property in req.body) {
        // rides[trip_id][property] = req.body[property];
    // }
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
    //Get the chatID of the user and join in a room of the same chatID
    // chatID = socket.handshake.query.chatID
    // socket.join(chatID)

    socket.on('addToRoom', (trip_id) => {
        roomsJoined[socket.id] = trip_id;
        socket.join(trip_id);
    });

    socket.on('leaveRoom', (trip_id) => {
        socket.leave(trip_id);
    });

    console.log("connected", socket.id);
    // socket.join('room 1');
    //Leave the room if the user closes the socket
    socket.on('disconnect', () => {
        console.log("disconnected", socket.id);
        delete connected_users[socket.id];
    })

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

    //Send message to only a particular user
    socket.on("message", message => {
        console.log(message, connected_users);
        io.in(roomsJoined[socket.id]).emit("recieveMessage", JSON.stringify({username: connected_users[socket.id]["username"], message: message, userType: connected_users[socket.id]["userType"]}));
        chat[roomsJoined[socket.id]].push({username: connected_users[socket.id]["username"], message: message, userType: connected_users[socket.id]["userType"]});
        // socket.emit('recieveMessage', message);
        // //Send message to only that particular room
        // socket.in(receiverChatID).emit('receive_message', {
        //     'content': content,
        //     'senderChatID': senderChatID,
        //     'receiverChatID':receiverChatID,
        // })
    })
});

server.listen(PORT, () => {
    console.log("listening on *:" + PORT)
})