import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/chatRoomScreen.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';
import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  bool isSearching = false;
  Stream<QuerySnapshot>? userStream;

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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  ConversationScreen(chatRoomId: chatRoomId,)));
  }


  Widget searchListUserTile({String? name}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ' ${name!}',
                style: mediumTextFieldStyle2,
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
    );
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds =
                      snapshot.data?.docs[index] as DocumentSnapshot;
                  return searchListUserTile(name: ds["name"]);
                },
              )
            : Container();
      },
    );
  }

  Future<dynamic> onSearchButtonClick() async {
    isSearching = true;
    setState(() {});
    userStream = await databaseMethods
        .getUserByUsername(searchTextEditingController.text);
    setState(() {});
  }


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002045),
      appBar: AppBar(
        actions:<Widget> [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ChatRoom()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.exit_to_app),
            ),
          ),
        ],
        title: const Text(
          '⚡Search Users ⚡',
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Overpass',
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
         Container(
            child: Column(
          children: <Widget>[
            Container(
              color: const Color(0x54FFFFFF),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: styleSearchText,
                      decoration: decorationSearchBar,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (searchTextEditingController.text != "") {
                        onSearchButtonClick();
                      }
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
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  ),
                ],
              ),
            ),
            searchUsersList(),
          ],
        ),
         ),
            ],
      ),
    );
  }
}

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String userEmail;
//   const SearchTile({Key? key, required this.userName, required this.userEmail})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               Text(
//                 userName,
//                 style: simpleTextFieldStyle,
//               ),
//               Text(
//                 userEmail,
//                 style: simpleTextFieldStyle,
//               ),
//             ],
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Text("Message"),
//           )
//         ],
//       ),
//     );
//   }
// }
