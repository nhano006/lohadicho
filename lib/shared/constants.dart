import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const titleStyle = TextStyle(
  fontSize: 22,
  color: Colors.black
);
const nameStyle = TextStyle(
  fontSize: 14,
  color: Colors.black
);
const contextStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
  fontStyle: FontStyle.normal
);
const linkStyle = TextStyle(
  fontSize: 11,
  decoration: TextDecoration.underline,
  color: Colors.blueAccent,
  fontStyle: FontStyle.italic
);

const tileColor = Colors.white70;
const bgColor = Colors.white60;
const barColor = Colors.white30;