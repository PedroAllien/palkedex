import 'package:flutter/material.dart';
import 'package:palkedex/app/helper/strings.dart';

abstract class Helper {
  static Color getTypeColor(String type) {
    switch (type) {
      case 'neutral':
        return Colors.grey.withOpacity(0.7);
      case 'grass':
        return Colors.green.withOpacity(0.7);
      case 'fire':
        return Colors.red.withOpacity(0.7);
      case 'water':
        return Colors.blue.withOpacity(0.7);
      case 'electric':
        return Colors.yellow.withOpacity(0.7);
      case 'ice':
        return Colors.lightBlue.withOpacity(0.7);
      case 'ground':
        return Colors.brown.withOpacity(0.7);
      case 'dark':
        return const Color.fromARGB(255, 65, 63, 63).withOpacity(0.7);
      case 'dragon':
        return Colors.amber.withOpacity(0.7);
      default:
        return Colors.grey.withOpacity(0.7);
    }
  }

  static String getTypeImage(String type) {
    switch (type) {
      case 'neutral':
        return Strings.neutralImage;
      case 'grass':
        return Strings.grassImage;
      case 'fire':
        return Strings.fireImage;
      case 'water':
        return Strings.waterImage;
      case 'electric':
        return Strings.electricImage;
      case 'ice':
        return Strings.iceImage;
      case 'ground':
        return Strings.groundImage;
      case 'dark':
        return Strings.darkImage;
      case 'dragon':
        return Strings.dragonImage;
      default:
        return Strings.neutralImage;
    }
  }

  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }
}
