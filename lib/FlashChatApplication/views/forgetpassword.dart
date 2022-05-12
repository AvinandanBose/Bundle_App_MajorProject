import 'package:flashchatapplication_new/FlashChatApplication/views/signin.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/signup.dart';
import 'package:flutter/material.dart';

import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';

import '../services/auth.dart';
import '../widgets/widget.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailTextEditingController = TextEditingController();
  AuthorizationMethods authorizationMethods = AuthorizationMethods();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002045),
      appBar: AppBar(
        title: Text(
          '⚡ Forget Password ⚡',
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Overpass',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/flashchatlogo.png'),
                      height: 140,
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
                                .hasMatch(value!) ?
                            null : "Enter correct email";
                          }
                        },
                        controller: emailTextEditingController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email'),
                        style: textStyleOfEmailPassUsername,
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          authorizationMethods.resetPass(
                              emailTextEditingController.text);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          decoration: signInFieldDecoration(),
                          child: const Text("Send Email",
                            style: simpleTextFieldStyle2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,
                                vertical: 8),
                            child: const Text(
                              'Login',
                              style: simpleTextFieldStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have account?",
                              style: simpleTextFieldStyle2),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

}
