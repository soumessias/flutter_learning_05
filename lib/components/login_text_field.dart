import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  final String? Function(String?)? validatorFunction;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    required this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.cyanAccent.shade700,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.cyanAccent.shade700,
        filled: true,
      ),
      validator: validatorFunction,
    );
  }
}
