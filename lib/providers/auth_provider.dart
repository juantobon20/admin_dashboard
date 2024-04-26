import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}


class AuthProvider extends ChangeNotifier {

  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  Future<bool> isAuthenticated() async {
    final String? token = LocalStorage.prefs.getString('token');
    if (token  == null) {
      authStatus = AuthStatus.notAuthenticated;
      return false;
    }

    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromJson(resp);

      LocalStorage.prefs.setString('token', authResponse.token);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  void login(String email, String password) {
    final data = {
      'correo': email,
      'password': password
    };

    CafeApi.post('/auth/login', data).then(
      (json) {
        final AuthResponse authResponse = AuthResponse.fromJson(json);
        user = authResponse.usuario;

        LocalStorage.prefs.setString('token', authResponse.token);
        authStatus = AuthStatus.authenticated;
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        CafeApi.configureDio();
        notifyListeners();
      }
    ).catchError((e) {
      NotificationService.showSnackbarError('Usuario / Password no son válidos');
    });
  }

  void register(String email, String password, String name) {
    final data = {
      'nombre': name,
      'correo': email,
      'password': password
    };

    CafeApi.post('/usuarios', data).then(
      (json) {
        final AuthResponse authResponse = AuthResponse.fromJson(json);
        user = authResponse.usuario;

        LocalStorage.prefs.setString('token', authResponse.token);
        authStatus = AuthStatus.authenticated;
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        
        CafeApi.configureDio();
        notifyListeners();
      }
    ).catchError((e) {
      NotificationService.showSnackbarError('Usuario / Password no son válidos');
    });
  }
}