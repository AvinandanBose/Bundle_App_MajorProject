import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: "Enter a value",
  hintStyle: TextStyle(
    color: Colors.white54,
  ),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const simpleTextFieldStyle= TextStyle(
  color: Colors.white,
  fontSize: 16.0,

);

const simpleTextFieldStyle2= TextStyle(
  color: Colors.white,
  fontSize: 17.0,

);
const mediumTextFieldStyle= TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  decoration: TextDecoration.underline,

);

const mediumTextFieldStyle2= TextStyle(
  color: Colors.white,
  fontSize: 17.0,
);


const simpleTextFieldStyle3= TextStyle(
  color: Colors.black87,
  fontSize: 17.0,

);

final signInFieldDecoration2 = BoxDecoration(
      color: Colors.white,
  borderRadius:  BorderRadius.circular(30.0),
);

const textStyleOfEmailPassUsername = TextStyle(
  color: Colors.white,
);

const styleSearchText = TextStyle(
  color: Colors.white,
);

const decorationSearchBar = InputDecoration(
  hintText: "search username....",
  hintStyle: TextStyle(
    color: Colors.white54,
  ),
  border: InputBorder.none,
);

class Constants{
  static  String myname = "";
}