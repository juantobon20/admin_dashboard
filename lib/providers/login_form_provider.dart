import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey();

  String email = "";
  String password = "";

  void validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form valido');
    } else {
      print('Form invalido');
    }

    print('$email ==== $password');
  }
}