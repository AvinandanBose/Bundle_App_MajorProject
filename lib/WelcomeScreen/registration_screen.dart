import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchatapplication_new/WelcomeScreen/login_screen.dart';
import 'package:flutter/material.dart';
import '../FlashChatApplication/helper/helperfunction.dart';
import '../FlashChatApplication/services/database.dart';
import '../MainBody/Body.dart';
import 'roundedbutton.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  QuerySnapshot<dynamic>? snapshotUserInfo;
  FirebaseAuth authMethods = FirebaseAuth.instance;

  bool showSpinner = false;
  String? email;
  String? password;


  Future<dynamic> signMeUp() async{
    try {
      if (formKey.currentState?.validate() == true) {
        Map<String, String> userInfoMap ={
          "REGname": userNameTextEditingController.text,
          "REGmail" : emailTextEditingController.text,
        };
        HelperFunction.saveUserEmailSharedPreference(emailTextEditingController.text);
        HelperFunction.saveUserNameSharedPreference(userNameTextEditingController.text);
        setState(() {
          showSpinner = true;
        });
        authMethods.createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text).then((value) =>
            print(value));


        databaseMethods.uploadLoggedInUserInfo(userInfoMap);
        HelperFunction.saveUserLoggedInSharedPreference(true);
        Future.delayed(const Duration(seconds: 2),(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const BodyMain() ));
        });

      }
      setState(() {
        showSpinner = false;
      });
    }on Exception catch(e){
      print(e.toString());
      throw 'Signup Doesnot occur';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Row(
      //   children:<Widget> [
      //    Expanded(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 140.0,
                      child: Image.asset('assets/images/bundle-app-logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (String?  value){
                          if(value != null && value.isEmpty == true){
                            return "Please fill up the blank";
                          }else if (value != null && value.length <= 3){
                            return "username must be greater than 3";
                          }
                          return null;
                        },
                        controller: userNameTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
                        style: simpleTextFieldStyle2,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value != null && value.isEmpty == true) {
                            return "Please Enter An Email";
                          } else {
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!) ?
                            null : "Enter correct email";
                          }
                        },
                        controller: emailTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
                        style: simpleTextFieldStyle2,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (String? value){
                          return (value != null && 6 < value.length )?null : "Please provide 6+ characters";
                        },
                        controller: passwordTextEditingController,
                        decoration:  kTextFieldDecoration.copyWith(
                            hintText: 'Password'),
                        style: simpleTextFieldStyle2,
                      ),
                    ],
                  ),
                ),
                RoundButton(
                  title: 'Register',
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });
                    signMeUp();
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?", style: simpleTextFieldStyle2),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "LogIn Now",
                          style: mediumTextFieldStyle,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
