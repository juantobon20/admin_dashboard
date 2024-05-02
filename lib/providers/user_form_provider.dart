import 'dart:typed_data';

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:admin_dashboard/models/usuario.dart';

class UserFormProvider extends ChangeNotifier {

  late GlobalKey<FormState> formKey;
  Usuario? user;

  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo, 
    String? uid,
    String? img
  }) {
    user = Usuario(
      rol: rol ?? user!.rol, 
      estado: estado ?? user!.estado, 
      google: google ?? user!.google, 
      nombre: nombre ?? user!.nombre, 
      correo: correo ?? user!.correo, 
      uid: uid ?? user!.uid
    );

    notifyListeners();
  }


  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future<bool> updateUser() async {
    if (!_validForm()) {
      return false;
    }

    final data = {
      "nombre" : user!.nombre,
      "correo" : user!.correo
    };

    try {
      await CafeApi.put('/usuarios/${user!.uid}', data);
      return true;
    } on DioException catch (e) {
      throw('Error en el updateUser: $e');
    }
  }

  Future<Usuario> uploadImage(Uint8List bytes) async {
    try {
      final resp = await CafeApi.uploadFiled('/uploads/usuarios/${user!.uid}', bytes);
      user = Usuario.fromJson(resp);  

      notifyListeners();
      return user!;
    } catch (e) {
      throw 'Error al actualizar imagen $e';
    }
  }
}