import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}


class AuthProvider extends ChangeNotifier {

  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }


  void login(String email, String password) {
    const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
    LocalStorage.prefs.setString('token', token);

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.navigateTo(Flurorouter.dashboardRoute);
  }

  Future<bool> isAuthenticated() async {
    final String? token = LocalStorage.prefs.getString('token');
    if (token  == null) {
      authStatus = AuthStatus.notAuthenticated;
      return false;
    }
    //TODO: ir al backend 
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}