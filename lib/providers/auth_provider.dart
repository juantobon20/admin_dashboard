import 'package:admin_dashboard/services/local_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  void login(String email, String password) {
    const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
    LocalStorage.prefs.setString('token', token);

    notifyListeners();
  }
}