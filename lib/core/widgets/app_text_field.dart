import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
    );
  }
}
