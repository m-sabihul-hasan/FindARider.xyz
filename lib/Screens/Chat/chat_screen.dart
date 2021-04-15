import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Chat/components/body.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io/socket_io.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

// IO.Socket socket = IO.io('http://localhost:3000');
// List<String> items = ['1'];
// @override
// void initState() {
//   // super.initState();
//   // connectToServer();
// }

// void connectToServer(IO.Socket socket) {
//   socket.onConnect((_) {
//     print('connected');
//     // socket.emit('message', 'test');
//   });
//   socket.on('recieveMessage', (data) {
//     //update_list
//     print(items);
//   });
//   socket.onDisconnect((_) => print('disconnect'));
//   socket.on('fromServer', (_) => print(_));
// }

// // Send Location to Server
// sendLocation(Map<String, dynamic> data) {
//   socket.emit("location", data);
// }

// // Listen to Location updates of connected usersfrom server
// handleLocationListen(Map<String, dynamic> data) async {
//   print(data);
// }

// // Send update of user's typing status
// sendTyping(bool typing) {
//   socket.emit("typing", {
//     "id": socket.id,
//     "typing": typing,
//   });
// }

// // Listen to update of typing status from connected users
// void handleTyping(Map<String, dynamic> data) {
//   print(data);
// }

// // Send a Message to the server
// sendMessage(String message) {
//   socket.emit("message", message);
// }

// // Listen to all message events from connected users
// void handleMessage(Map<String, dynamic> data) {
//   print(data);
// }
