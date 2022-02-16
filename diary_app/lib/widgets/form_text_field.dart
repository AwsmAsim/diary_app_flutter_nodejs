import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {

  final String hintText;
  TextEditingController controller;
  final bool obscureText;

  FormTextField({required this.hintText,required this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.cyan
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        // border: Border.all()
      ),
    );
  }
}
