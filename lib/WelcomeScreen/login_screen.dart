import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flashchatapplication_new/WelcomeScreen/registration_screen.dart';
import 'package:flashchatapplication_new/FlashChatApplication/helper/helperfunction.dart';

import '../FlashChatApplication/services/database.dart';
import '../MainBody/Body.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'roundedbutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  QuerySnapshot<dynamic>? snapshotUserInfo;
  FirebaseAuth authMethods = FirebaseAuth.instance;


  bool showSpinner = false;
  String? email;
  String? password;




  Future<dynamic> signIn() async {
    try {
      if (formKey.currentState?.validate() == true) {
        HelperFunction.saveUserEmailSharedPreference(
            emailTextEditingController.text);
        setState(() {
          showSpinner = true;
        });
        databaseMethods
            .getLogInUserByUserEmail(emailTextEditingController.text)
            .then((value) {
          snapshotUserInfo = value as QuerySnapshot?;
          HelperFunction.saveUserNameSharedPreference(
              snapshotUserInfo!.docs[0].data()["REGname"]);
        });

        authMethods
            .signInWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text)
            .then((value) {
          if (value != null) {
            HelperFunction.saveUserLoggedInSharedPreference(true);
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BodyMain()));
            });
          }
        });
      }
      setState(() {
        showSpinner = false;
      });
    } on Exception catch (e) {
      print(e.toString());
      throw 'SigIn Doesnot occur';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                      validator: (value) {
                        if (value != null && value.isEmpty == true) {
                          return "Please Enter An Email";
                        } else {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)
                              ? null
                              : "Enter correct email";
                        }
                      },
                      controller: emailTextEditingController,
                      decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Email'),
                      style: simpleTextFieldStyle2,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (String? value) {
                        return (value != null && 6 < value.length)
                            ? null
                            : "Please provide 6+ characters";
                      },
                      controller: passwordTextEditingController,
                      decoration:  kTextFieldDecoration.copyWith(
                          hintText: 'Password'),
                      style: simpleTextFieldStyle2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundButton(
                  title: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });
                    signIn();
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have account?", style: simpleTextFieldStyle2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Register Now",
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
