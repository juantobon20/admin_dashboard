import 'dart:async';

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {

  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  UsersProvider() {
    getPaginatedUsers();
  }

  void getPaginatedUsers() async {
      final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=10');
      final usersResp = UsersResponse.fromJson(resp);

      users = [...usersResp.usuarios];
      isLoading = false;

      notifyListeners();
  }

  Future<Usuario?> getUserById(String uid) async {
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final usersResp = Usuario.fromJson(resp);

      return usersResp;
    } catch (e) {
      return null;
    }
  }

  void orderByColumn<T>(Comparable<T> Function(Usuario users) getField) {

    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      if (ascending) {
        return Comparable.compare(aValue, bValue);
      } else {
        return Comparable.compare(bValue, aValue);
      }
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    final index = users.indexWhere((element) => element.uid == newUser.uid);
    if (index >= 0) {
      users[index] = newUser;
    }

    notifyListeners();
  }
}