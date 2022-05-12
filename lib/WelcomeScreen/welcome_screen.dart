import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'roundedbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  AnimationController? controller1;
  Animation? animation;
  Animation? animation2;

  void update() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    controller?.forward();
    animation =
        ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller!);

    animation2 =  CurvedAnimation(parent: controller!, curve: Curves.easeInCirc);

    controller?.addListener(
      () {
        setState(() {});
        print(animation?.value);
        print(animation2?.value);
      },
    );
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/bundle-app-logo.png'),
                      height: animation2!.value*100,
                    ),
                  ),
                ),
                TextLiquidFill(
                  boxWidth: 150,
                  boxHeight: 200,
                  boxBackgroundColor: Colors.deepOrange,
                  loadDuration: const Duration(seconds: 6),
                  waveDuration: const Duration(seconds: 2),
                  text:  'Bundle App',
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
             RoundButton( title: 'Log In',
            color:  Colors.lightBlueAccent,
               onPressed: (){
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => LoginScreen()),
                 );
               },
            ),
            RoundButton( title: 'Register',
              color:  Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );;
              },
            ),

            const SizedBox(
              height: 48.0,
            ),
          ],
        ),
      ),
    );
  }
}
