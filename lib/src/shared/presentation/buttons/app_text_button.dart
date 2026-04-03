import 'package:flutter/material.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.style,
    this.color,
    this.underline = false,
    this.underlineColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final TextStyle? style;
  final bool underline;
  final Color? underlineColor;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  var hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      hoverColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onHover: (h) {
        hover = h;
        setState(() {});
      },
      child: Text(
        widget.text,
        style: widget.style ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
