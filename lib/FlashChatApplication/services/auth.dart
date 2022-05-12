
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchatapplication_new/FlashChatApplication/models/user.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/helperfunction.dart';
import '../views/chatRoomScreen.dart';
class AuthorizationMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CurrUser? _userFromFirebaseUser(User? user) {
    return user != null ? CurrUser (userId: user.uid) : null;
  }
 Future <dynamic> signInwithEmailandPassword (String email, String password) async{
   try{
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     User? user = userCredential.user;
     return _userFromFirebaseUser(user);
   }on Exception catch(e){
     print(e.toString());
     throw 'Authorization Error';
   }
 }
  Future <dynamic> signUpwithEmailandPassword (String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } on Exception catch (e) {
      print(e.toString());
      throw 'Authorization Error';
    }
  }
  Future<dynamic> resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw 'Authorization Error';
    }
  }
  Future<dynamic> signOut()async{
    try {
      return await _auth.signOut();
    } on Exception catch (e) {
      print(e.toString());
      throw 'Authorization Error';
    }

  }
///For Signin with Google
  Future<dynamic> signInwithGoogle(BuildContext context)async{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication?  googleSignInAuthentication = await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );
    UserCredential userCredential   =  await _firebaseAuth.signInWithCredential(credential);
    User? userDetails = userCredential.user;
    if(userCredential != null){
      HelperFunction.saveUserEmailSharedPreference(userDetails?.email);
      HelperFunction.saveUserNameSharedPreference(userDetails?.displayName);
      Map<String,dynamic>userInfoMap = {
        "email" : userDetails?.email,
        "name" : userDetails?.displayName,
      };
      DatabaseMethods().addUserInfoDB( userDetails?.uid, userInfoMap).then((value) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  const ChatRoom()));
        });
      });

    }
  }

}