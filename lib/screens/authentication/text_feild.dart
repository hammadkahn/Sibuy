import 'package:flutter/material.dart';

TextField? text() {
  TextField(
      decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
      borderRadius: BorderRadius.circular(16),
    ),
    hintText: 'Email',
  ));
  return null;
}
