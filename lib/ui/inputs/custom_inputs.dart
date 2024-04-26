import 'package:flutter/material.dart';

class CustomInputs {

  static InputDecoration inputDecoration({
    required String hint,
    required String label,
    required IconData iconData,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))
      ),
      hintText: hint,
      label: Text(label),
      prefixIcon: Icon(iconData, color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon
  }) => InputDecoration(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    hintText: hint,
    prefixIcon: Icon(icon, color: Colors.grey),
    labelStyle: const TextStyle(color: Colors.grey),
    hintStyle: const TextStyle(color: Colors.grey),
  );
}