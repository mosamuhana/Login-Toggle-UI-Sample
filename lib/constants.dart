import 'package:flutter/material.dart';

const Color startColor = Colors.blueAccent; //const Color(0xFFfbab66);
const Color endColor = Colors.blueGrey; //const Color(0xFFf7418c);

const buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(5)),
  boxShadow: <BoxShadow>[
    BoxShadow(color: startColor, offset: Offset(1, 6), blurRadius: 10),
    BoxShadow(color: endColor, offset: Offset(1, 6), blurRadius: 10),
  ],
  color: startColor,
);
