import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  // final Function()? onChanged;

  const MyTextField({
    super.key,
    //   required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    //   this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller,
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
    );
  }
}
