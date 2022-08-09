import 'package:admiralui_flutter/src/Widgets/Controlls/PrimaryButton/primary_button_scheme.dart';
import 'package:admiralui_flutter/src/Widgets/Controlls/icon_direction.dart';
import 'package:flutter/material.dart';
import '../button_size_type.dart';
import '../controll_parameter.dart';

/// An PrimaryButton-style button.
///
/// Takes in a text or an icon that fades out and in on touch. May optionally have a
/// background.
///
/// You can create buttons in three sizes: (small, medium, big) by specifying size Type in init PrimaryButtonStyle:
///  Big - the main button, the width of which depends on the width of the screen;
///  Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
///  Small - changes its width depending on the content inside it, often used with the keyboard.
///
class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isEnable;
  final ButtonSizeType sizeType;
  final Widget? icon;
  final IconDirection? direction;
  final PrimaryButtonScheme? scheme;

  /// Creates an PrimaryButton.
  const PrimaryButton(
      {Key? key,
      this.onPressed,
      this.title = '',
      this.isEnable = true,
      this.sizeType = ButtonSizeType.big,
      this.icon,
      this.direction,
      this.scheme})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;
  late PrimaryButtonScheme scheme;

  @override
  void initState() {
    super.initState();
    scheme = widget.scheme ?? PrimaryButtonScheme();
  }

  @override
  Widget build(BuildContext context) {
    var backgroundNormal = scheme.buttonColor.paramter(ControlState.normal);
    var backgroundHighlighted =
        scheme.buttonColor.paramter(ControlState.highlighted);
    var backgroundDisabled = scheme.buttonColor.paramter(ControlState.disabled);
    var background = widget.isEnable
        ? (_isPressed ? backgroundHighlighted : backgroundNormal)
        : backgroundDisabled;

    var textColorNormal = scheme.textColor.paramter(ControlState.normal);
    var textColorDisabled = scheme.textColor.paramter(ControlState.disabled);
    var textColor = widget.isEnable ? textColorNormal : textColorDisabled;

    return GestureDetector(
      onTap: () => widget.onPressed?.call(),
      onTapUp: (_) => setHighlighted(false),
      onTapDown: (_) => setHighlighted(true),
      onTapCancel: () => setHighlighted(false),
      child: Container(
          width: widget.sizeType.width,
          height: widget.sizeType.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: (widget.icon != null &&
                        widget.direction == IconDirection.left)
                    ? widget.icon
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: scheme.fontSize,
                    fontFamily: scheme.fontFamily,
                    fontWeight: scheme.fontWeight,
                  ),
                ),
              ),
              SizedBox(
                child: (widget.icon != null &&
                        widget.direction == IconDirection.right)
                    ? widget.icon
                    : null,
              ),
            ],
          )),
    );
  }

  setHighlighted(bool highlighted) {
    setState(() {
      _isPressed = highlighted;
    });
  }
}
