import 'package:flashchatapplication_new/FlashChatApplication/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'BitCoinTicker/price_screen.dart';
import 'MainBody/Body.dart';
import 'WelcomeScreen/login_screen.dart';
import 'WelcomeScreen/welcome_screen.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   MaterialApp(
      debugShowCheckedModeBanner: false,

theme: ThemeData.dark(),

      home:  WelcomeScreen(),

    );

  }
}
