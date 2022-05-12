import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  const ConversationScreen({Key? key, required this.chatRoomId})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot>? chatMessageStream;
  Stream<QuerySnapshot>? userStream;


  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds =
                      snapshot.data?.docs[index] as DocumentSnapshot;

                  return MessageTile(
                      message: ds["message"],
                      sendBy: ds["sendBy"] == Constants.myname);
                },
              )
            : Container();
      },
    );
  }

  Widget MessageTile({String? message, bool? sendBy}) {
    return Container(
      padding: EdgeInsets.only(left: sendBy! ? 0 : 24, right: sendBy ? 24 : 0),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: sendBy ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: sendBy
                ? [
                    const Color(0xff007EF4),
                    const Color(0xff2A75BC),
                  ]
                : [
                    const Color(0x1AFFFFFF),
                    const Color(0x1AFFFFFF),
                  ],
          ),
          borderRadius: sendBy
              ? const BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                ),
        ),
        child: Text(
          '$message',
          style: mediumTextFieldStyle2,
        ),
      ),
    );
  }

  Future<dynamic> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myname,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      await databaseMethods.addConversationMessages(
          widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002045),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '⚡ Flash Chat',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.yellowAccent,
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: const Color(0x54FFFFFF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: styleSearchText,
                        decoration: decorationSearchBar.copyWith(
                            hintText: 'Message...'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ]),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset("assets/images/send.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
