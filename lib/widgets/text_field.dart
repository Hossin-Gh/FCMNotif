import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
  CustomTextFild({
    super.key,
    required this.hint,
    required this.isobscureText,
    required this.controller,
    required this.type,
  });

  final String? hint;
  final bool isobscureText;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        autofocus: true,
        controller: controller,
        obscureText: isobscureText,
        style: TextStyle(
          color: Colors.white,
        ),
        keyboardType: type,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 24,
              fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
