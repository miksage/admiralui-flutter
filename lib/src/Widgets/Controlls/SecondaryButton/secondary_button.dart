import 'package:admiralui_flutter/src/Widgets/Controlls/SecondaryButton/secondary_button_scheme.dart'
    show SecondaryButtonScheme;
import 'package:admiralui_flutter/src/Widgets/Controlls/icon_direction.dart';
import 'package:flutter/material.dart';
import '../button_size_type.dart';
import '../controll_parameter.dart';

/// An SecondaryButton-style button.
///
/// Takes in a text or an icon that fades out and in on touch. May optionally have a
/// background.
///
/// You can create buttons in three sizes: (small, medium, big) by specifying size Type in init PrimaryButtonStyle:
///  Big - the main button, the width of which depends on the width of the screen;
///  Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
///  Small - changes its width depending on the content inside it, often used with the keyboard.
///
class SecondaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isEnable;
  final ButtonSizeType sizeType;
  final Widget? icon;
  final IconDirection? direction;
  final SecondaryButtonScheme? scheme;

  /// Creates an SecondaryButton.
  const SecondaryButton(
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
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;
  late SecondaryButtonScheme scheme;

  @override
  void initState() {
    super.initState();
    scheme = widget.scheme ?? SecondaryButtonScheme();
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
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 2, color: background),
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
                    color: background,
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
