import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey();

  String name = "";
  String email = "";
  String password = "";

  void validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valido');
    } else {
      print('Form invalido');
    }

    print('$email ==== $password ===== $name');
  }
}