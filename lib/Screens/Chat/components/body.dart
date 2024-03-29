import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Chat/chat_screen.dart';
import 'package:flutter_app/Screens/Chat/components/background.dart';
import 'package:flutter_app/Screens/TripDetails/tripdetails_screen.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/components/rounded_button.dart';
import 'package:flutter_app/components/rounded_input_field.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io/socket_io.dart';
import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  // IO.Socket socket = IO.io('http://localhost:3000');
  List messages = [];
  // List<String> messages = [];
  String message = "asd";
  final messageHolder = TextEditingController();
  Map<String, Map> message_type = {
    "1": {
      "bubble_type": BubbleType.sendBubble,
      "alignment": Alignment.topRight,
      "background_color": Colors.blue,
      "text_color": Colors.white,
    },
    "2": {
      "bubble_type": BubbleType.receiverBubble,
      "alignment": Alignment.topLeft,
      "background_color": Color(0xffE7E7ED),
      "text_color": Colors.black,
    },
  };
  @override
  void initState() {
    //   // super.initState();
    connectToServer(socket);
  }

  void connectToServer(IO.Socket socket) {
    socket.on('recieveMessage', (data) {
      setState(() {
        data = jsonDecode(data);
        if (data["username"] != finalUsername) {
          messages.add({
            "username": data["username"],
            "message": data["message"],
            "messageType": "2",
            "userType": data["userType"],
          });
        }
      });
      // print(messages);
    });
    // socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.on('previousChat', (chat) {
      print("CHAT");
      print(chat);
      chat = chat.replaceAll(new RegExp(r'},{'), '},,{');
      print(chat);
      chat = chat.split(',,');
      print(chat);
      if (chat[0] == "") return;
      List<Map<dynamic, dynamic>> jsonChat = [];
      for (int i = 0; i < chat.length; i++) {
        jsonChat.add(jsonDecode(chat[i]));
        if (jsonChat[i]["username"] == finalUsername)
          jsonChat[i]["messageType"] = "1";
        else
          jsonChat[i]["messageType"] = "2";
      }
      setState(() {
        messages = jsonChat;
      });
    });

    socket.emit('previousChatRequest', "");
  }

// Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    socket.emit("location", data);
  }

// Listen to Location updates of connected usersfrom server
  handleLocationListen(Map<String, dynamic> data) async {
    print(data);
  }

// Send update of user's typing status
  sendTyping(bool typing) {
    socket.emit("typing", {
      "id": socket.id,
      "typing": typing,
    });
  }

// Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }

// Send a Message to the server
  sendMessage(String message) {
    socket.emit("message", message);
    messages.add({
      "username": finalUsername,
      "message": message,
      "messageType": "1",
      "userType": user,
    });
  }

// Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }

  // void update_chat(String data) {
  //   setState(() {
  //     items.add(data);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
        body: Column(children: <Widget>[
      // SizedBox(height: size.height * 0.1),
      Text(
        'Trip ID: ${bookedTripDetails["tripID"]}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      SizedBox(height: size.height * 0.05),
      Expanded(
          child: Scrollbar(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // height: 55,
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                      child: Center(
                          child: ChatBubble(
                        clipper: ChatBubbleClipper2(
                            // type: (messages[index]["username"] == finalUsername)
                            //     ? BubbleType.sendBubble
                            //     : BubbleType.receiverBubble),
                            type: message_type[messages[index]["messageType"]]
                                ["bubble_type"]),
                        alignment: message_type[messages[index]["messageType"]]
                            ["alignment"],
                        margin: EdgeInsets.only(top: 20),
                        backGroundColor:
                            message_type[messages[index]["messageType"]]
                                ["background_color"],
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${messages[index]["username"]} (${messages[index]["userType"]}) ',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: message_type[messages[index]
                                        ["messageType"]]["text_color"]),
                              ),
                              TextSpan(
                                text: '\n\n${messages[index]["message"]}',
                                style: TextStyle(
                                  color: message_type[messages[index]
                                      ["messageType"]]["text_color"],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      )),
                    );
                  }))),

      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(15),
            child: FloatingActionButton.extended(
              onPressed: () {
                navigatorKey.currentState.push(
                    MaterialPageRoute(builder: (context) => TripDetails()));
              },
              icon: Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  )),
              label: Text("Back",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              backgroundColor: Colors.black,
              elevation: 0,
            ))
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
            controller: messageHolder,
            hintText: "Type message here",
            onChanged: (value) {
              message = value;
            },
            icon: null,
          ),
          FloatingActionButton(
            onPressed: () {
              messageHolder.clear();
              sendMessage(message);
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
            backgroundColor: Colors.blue,
            elevation: 0,
          ),
        ],
      ),
    ]));
  }
}
