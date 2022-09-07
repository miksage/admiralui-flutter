import 'package:admiralui_flutter/src/widgets/controls/control_parameter.dart';
import 'package:flutter/material.dart';

class SecondaryButtonScheme {
  SecondaryButtonScheme()
      : fontSize = 16,
        fontFamily = '.SF UI Display',
        fontWeight = FontWeight.w500 {
    buttonColor.set(
      const Color(0xFF3A83F1),
      ControlState.normal,
    );
    buttonColor.set(
      const Color(0xFF316FCC),
      ControlState.highlighted,
    );
    buttonColor.set(
      const Color(0xFF3A83F1).withOpacity(0.6),
      ControlState.disabled,
    );
  }

  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  ControlParameter<Color> buttonColor = ControlParameter<Color>();
}
