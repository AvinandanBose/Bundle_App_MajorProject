import 'package:flutter/material.dart';

import '../../MainBody/Body.dart';

AppBar appBarMain(BuildContext context) {
 return AppBar(
  title: Image.asset(
   "assets/images/chatapplogo.jpg",
   fit: BoxFit.contain,
   height: 50,
  ),
  toolbarHeight: 70,
  elevation: 20.0,
  centerTitle: false,
  actions:<Widget>[
   GestureDetector(
    onTap: () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BodyMain()));
    },
    child: Container(
     padding: const EdgeInsets.symmetric(horizontal: 10),
     child: const Icon(Icons.exit_to_app),
    ),
   ),
  ],
 );
}

InputDecoration textFieldInputDecoration(String hintText){
 return  InputDecoration(
  hintText: hintText,
  hintStyle: const TextStyle(
   color: Colors.white54,
  ),
  contentPadding:
  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: const OutlineInputBorder(
   borderSide:
   BorderSide(color: Colors.lightBlueAccent, width: 1.0),
   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: const OutlineInputBorder(
   borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
 );
}

// TextStyle simpleTextFieldStyle(){
//  return const TextStyle(
//  color: Colors.white,
//   fontSize: 16,
//  );
// }

BoxDecoration signInFieldDecoration (){
 return BoxDecoration(
  gradient:const LinearGradient(
      colors: [
       Color(0xff007EF4),
       Color(0xff2A75BC),
      ]

  ),
  borderRadius:  BorderRadius.circular(30.0),
 );
}

