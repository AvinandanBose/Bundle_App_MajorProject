import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchatapplication_new/FlashChatApplication/helper/helperfunction.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/signup.dart';
import 'package:flashchatapplication_new/FlashChatApplication/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../services/auth.dart';
import 'chatRoomScreen.dart';
import 'forgetpassword.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  AnimationController? controller;
  Animation? animation;
  Animation? animation2;
  bool isLoading = false;
  FirebaseAuth authMethods = FirebaseAuth.instance;
  QuerySnapshot<dynamic>? snapshotUserInfo;


  void update() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller?.forward();
    animation = ColorTween(begin: Colors.red, end: const Color(0xFF002045))
        .animate(controller!);
    animation2 = CurvedAnimation(parent: controller!, curve: Curves.easeInCirc);
    controller?.addListener(
      () {
        setState(() {});
      },
    );
  }

  Future<dynamic> signIn() async {
    try {
      if (formKey.currentState?.validate() == true) {
        HelperFunction.saveUserEmailSharedPreference(
            emailTextEditingController.text);
        setState(() {
          isLoading = true;
        });
        databaseMethods
            .getUserByUserEmail(emailTextEditingController.text)
            .then((value) {
          snapshotUserInfo = value as QuerySnapshot?;
          HelperFunction.saveUserNameSharedPreference(
              snapshotUserInfo!.docs[0].data()["name"]);
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
                      builder: (context) => const ChatRoom()));
            });
          }
        });
      }
      setState(() {
        isLoading = false;
      });
    } on Exception catch (e) {
      print(e.toString());
      throw 'SigIn Doesnot occur';
    }
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      appBar: appBarMain(context),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            child: Image.asset('assets/images/flashchatlogo.png'),
                            height: animation2!.value * 140,
                          ),
                        ),
                      ),
                      TypewriterAnimatedTextKit(
                        speed: const Duration(seconds: 1),
                        pause: const Duration(seconds: 0),
                        text: const ['Flash Chat'],
                        textStyle: const TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
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
                          style: textStyleOfEmailPassUsername,
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
                          decoration: textFieldInputDecoration('Password'),
                          style: textStyleOfEmailPassUsername,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgetPassword()),
                      );
                    },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: const Text(
                            'Forgot Password?',
                            style: simpleTextFieldStyle,
                          ),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: signInFieldDecoration(),
                      child: const Text(
                        "Sign In",
                        style: simpleTextFieldStyle2,
                      ),
                    ),
                  ),

                  ///For Signin with Google
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      AuthorizationMethods().signInwithGoogle(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: signInFieldDecoration2,
                      child: const Text(
                        "Sign In with Google",
                        style: simpleTextFieldStyle3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
                                builder: (context) => const SignUp()),
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
        ),
      ),
    );
  }
}
