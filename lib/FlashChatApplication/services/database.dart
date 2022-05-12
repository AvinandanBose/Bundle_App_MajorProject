import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<Stream<QuerySnapshot>> getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .snapshots();
  }


  Future<Stream<QuerySnapshot>> getUserByUserEmail(String userEmail) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLogInUserByUserEmail(String userEmail) async {
    return FirebaseFirestore.instance
        .collection("REGusers")
        .where("REGmail", isEqualTo: userEmail)
        .snapshots();
  }



  Future<dynamic> uploadUserInfo(
       Map<String, dynamic> userMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .add(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<dynamic> uploadLoggedInUserInfo(
      Map<String, dynamic> userMap) async {
    return await FirebaseFirestore.instance
        .collection("REGusers")
        .add(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }


  Future<dynamic> createChatRoom(String chatRoomId, chatRoomMap) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
      throw ' No data has been set';
    });
  }

  Future<dynamic> addConversationMessages(
  String chatRoomId,Map<String, dynamic> messageMap) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e);
      throw ' No data has been set';
    });
  }

  Future<dynamic> getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  Future<dynamic> getUser() async {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots();
  }

  Future<dynamic> getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
///For Signin with Google
  Future<dynamic> addUserInfoDB(
      String? userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }
}
