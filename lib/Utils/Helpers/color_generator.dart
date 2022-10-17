import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timer/Constants/colors.dart';

class ColorGenerator {
  int random = Random().nextInt(MyColors.challengeColors.length);

  Color generateColor(int index) {
    if (index < MyColors.challengeColors.length) {
      return MyColors.challengeColors[index];
    } else {
      return MyColors.challengeColors[random];
    }
  }
}
