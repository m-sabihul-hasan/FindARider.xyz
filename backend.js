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

connected_users = {};

io.on('connection', socket => {
    //Get the chatID of the user and join in a room of the same chatID
    // chatID = socket.handshake.query.chatID
    // socket.join(chatID)
    console.log("connected", socket.id);
    socket.join('room 1');
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
    })

    //Send message to only a particular user
    socket.on("message", message => {
        console.log(message, connected_users);
        io.in('room 1').emit("recieveMessage", JSON.stringify({username: connected_users[socket.id]["username"], message: message, userType: connected_users[socket.id]["userType"]}));
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