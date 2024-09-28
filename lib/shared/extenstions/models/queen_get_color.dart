import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

extension QueenGetColor on Queen {
  Color get color {
    Color color = Colors.black;
    int colorCode = birthDate.year % 5;
    switch (colorCode) {
      case 0:
        color = Colors.blue;
      case 1:
        color = Colors.white;
      case 2:
        color = Colors.yellow;
      case 3:
        color = Colors.red;
      case 4:
        color = Colors.green;
    }

    if(isAlive == false) {
      color = color.withOpacity(0.5);
    }
    return color;
  }
}