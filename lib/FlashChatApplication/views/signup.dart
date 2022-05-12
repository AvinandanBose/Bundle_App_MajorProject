import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchatapplication_new/FlashChatApplication/helper/helperfunction.dart';
import 'package:flashchatapplication_new/FlashChatApplication/services/database.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/chatRoomScreen.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/signin.dart';
import 'package:flashchatapplication_new/FlashChatApplication/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../services/auth.dart';
import 'forgetpassword.dart';

class SignUp extends StatefulWidget {



  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  DatabaseMethods databaseMethods = DatabaseMethods();
  FirebaseAuth authMethods = FirebaseAuth.instance;



  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

 Future<dynamic> signMeUp() async{
    try {
      if (formKey.currentState?.validate() == true) {
        Map<String, String> userInfoMap ={
          "name": userNameTextEditingController.text,
          "email" : emailTextEditingController.text,
        };
        HelperFunction.saveUserEmailSharedPreference(emailTextEditingController.text);
        HelperFunction.saveUserNameSharedPreference(userNameTextEditingController.text);
        setState(() {
          isLoading = true;
        });
        authMethods.createUserWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text).then((value) =>
            print(value));


        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunction.saveUserLoggedInSharedPreference(true);
        Future.delayed(const Duration(seconds: 2),(){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ChatRoom()  ));
        });


      }
      setState(() {
        isLoading = false;
      });
    }on Exception catch(e){
      print(e.toString());
      throw 'Signup Doesnot occur';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      backgroundColor: const Color(0xFF002045),
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
                children:   <Widget>[
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
                          style: textStyleOfEmailPassUsername,
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
                          style: textStyleOfEmailPassUsername,
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
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgetPassword()),
                      );
                    },

                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    onTap: (){
                      signMeUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      decoration:  signInFieldDecoration(),
                      child: const Text("Sign Up", style: simpleTextFieldStyle2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ///For Signin with Google
                  GestureDetector(
                    onTap: (){
                      AuthorizationMethods().signInwithGoogle(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      decoration:  signInFieldDecoration2,
                      child: const Text("Sign Up with Google", style: simpleTextFieldStyle3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  <Widget>[
                      Text("Already have an account?" , style: simpleTextFieldStyle2),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>const SignIn()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical:8) ,
                            child: Text("Sign In Now",style:mediumTextFieldStyle , ),
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

