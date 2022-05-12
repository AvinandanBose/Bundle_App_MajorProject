import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchatapplication_new/FlashChatApplication/helper/helperfunction.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/search.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';

import 'conversation_screen.dart';

class ChatRoom extends StatefulWidget {

  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  FirebaseAuth authMethods = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream<QuerySnapshot>? chatRoomsStream;

  ///providechatroomID
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return " $b\_$a";
    } else {
      return " $a\_$b";
    }
  }

  ///Create Chat Room
  Future<dynamic> createChatRoomAndStartConversation(String userName) async {
    String chatRoomId = getChatRoomId(userName, Constants.myname);
    List<String> users = [userName, Constants.myname];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId,
    };

    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  chatRoomId: chatRoomId,
                )));
  }

  Widget getUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds =
                      snapshot.data?.docs[index] as DocumentSnapshot;

                  return getUserTile(name: ds["name"]);
                },
              )
            : Container();
      },
    );
  }

  Widget getUserTile({String? name}) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    ' ${name!}',
                    style: mediumTextFieldStyle2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 50.0,
            ),
            GestureDetector(
              onTap: () {
                createChatRoomAndStartConversation(name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text(
                  "Message",
                  style: mediumTextFieldStyle2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    databaseMethods.getUser().then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });

    getUserInfo();
  }

  Future<dynamic> getUserInfo() async {
    print(HelperFunction.getUserNameSharedPreference());
    Constants.myname = await HelperFunction.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002045),
      appBar: AppBar(
        title: Text(
          '⚡Chat Room ⚡',
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Overpass',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '⚡List Of All Users In ChatRoom ⚡',
                          style: TextStyle(
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Overpass',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                getUserList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
