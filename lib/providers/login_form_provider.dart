import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey();

  String email = "";
  String password = "";

  bool validateForm() => formKey.currentState!.validate();
}