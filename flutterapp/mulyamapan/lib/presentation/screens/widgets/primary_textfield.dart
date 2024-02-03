import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool enabledText;

  const PrimaryTextField(
      {super.key,
      required this.labelText,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.enabledText = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
          labelText: labelText,
          labelStyle: TextStyle(
            fontStyle: FontStyle.italic,
          ),
          enabled: enabledText),
    );
  }
}
