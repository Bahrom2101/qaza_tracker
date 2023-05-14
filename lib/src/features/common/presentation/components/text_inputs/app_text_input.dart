import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    Key? key,
    this.focus,
    this.controller,
    this.focused = false,
    this.onTapSuffix,
    required this.borderRadius,
    this.hintText = '',
    this.text,
    this.maxLength,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final FocusNode? focus;
  final TextEditingController? controller;
  final bool focused;
  final VoidCallback? onTapSuffix;
  final double borderRadius;
  final String hintText;
  final String? text;
  final int? maxLength;
  final Function(String)? onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      focusNode: readOnly ? null : focus,
      controller: controller ?? TextEditingController(text: text),
      maxLines: 1,
      onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d'))],
      style: const TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: focused
            ? Transform.scale(
                scale: 0.7,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade200,
                    shape: const CircleBorder(),
                  ),
                  icon: const Icon(Icons.check),
                  onPressed: onTapSuffix,
                ),
              )
            : null,
        counterText: '',
        contentPadding: const EdgeInsets.all(10),
        focusColor: Colors.blue,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
