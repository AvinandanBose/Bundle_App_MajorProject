import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchatapplication_new/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/FlashChatApplication/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RestfulAPIBody.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({Key? key}) : super(key: key);

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  FirebaseAuth? firebaseAuth ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF10163B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B102A),
          title: const Text('BUNDLE APP'),
          centerTitle: true,
          actions:<Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  firebaseAuth?.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>  WelcomeScreen()));
                });

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ResfulAPIBody()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 200.0,
                        width: 170.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/restfulApi.png',
                              height: 130,
                              width: 130,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Restful Api Apps',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 200.0,
                        width: 170.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/flashchatlogo.png',
                              height: 130,
                              width: 130,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Flash Chat App',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
