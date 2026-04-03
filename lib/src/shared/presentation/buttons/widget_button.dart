import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    super.key,
    this.onTap,
    this.onTapDown,
    required this.child,
    this.buttonColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.hoverColor,
    this.onHover,
    this.decoration,
    this.tapColor,
    this.longPressColor,
    this.border,
    this.onLongPress,
  });

  final VoidCallback? onTap;
  final void Function(TapDownDetails)? onTapDown;
  final Widget child;
  final Color? buttonColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Color? hoverColor;
  final ValueChanged<bool>? onHover;
  final Decoration? decoration;
  final Color? tapColor;
  final Color? longPressColor;
  final BoxBorder? border;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    var kBorderRadius16 = BorderRadius.all(Radius.circular(16));
    return Material(
      borderRadius: borderRadius ?? kBorderRadius16,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius ?? kBorderRadius16,
        hoverColor: hoverColor,
        onTap: onTap,
        onLongPress: onLongPress,
        onTapDown: onTapDown,
        onHover: onHover,
        splashColor: tapColor,
        highlightColor: longPressColor,
        child: Ink(
          width: width,
          height: height,
          decoration: decoration ??
              BoxDecoration(
                color: buttonColor ?? Colors.black,
                borderRadius: borderRadius ?? kBorderRadius16,
                border: border,
              ),
          padding: padding ?? EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}
