import 'package:flutter/material.dart';
import '../controll_parameter.dart';

class PrimaryButtonScheme {
  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  ControlParameter textColor = ControlParameter();
  ControlParameter buttonColor = ControlParameter();

  PrimaryButtonScheme()
      : fontSize = 16,
        fontFamily = '.SF UI Display',
        fontWeight = FontWeight.w500 {
    textColor.set(const Color(0xFFFFFFFF), ControlState.normal);
    textColor.set(
        const Color(0xFFFFFFFF).withOpacity(0.6), ControlState.disabled);

    buttonColor.set(const Color(0xFF3A83F1), ControlState.normal);
    buttonColor.set(const Color(0xFF316FCC), ControlState.highlighted);
    buttonColor.set(
        const Color(0xFF3A83F1).withOpacity(0.6), ControlState.disabled);
  }
  // TODO: when theme will done
  // var _theme = theme ?? AppTheme.light;
}
