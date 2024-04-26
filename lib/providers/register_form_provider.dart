import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey();

  String name = "";
  String email = "";
  String password = "";

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      print('$email ==== $password ===== $name');
      return true;
    } else {
      print('Form invalido');
      return false;
    }
  }
}