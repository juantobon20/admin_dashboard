import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {

  List<Categoria> categories = [];

  void getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromJson(resp);

    categories = categoriesResponse.categorias;
    notifyListeners();
  }

  Future<void> newCategory(String name) async {
    final data = {
      "nombre" : name
    };

    try {
      final json = await CafeApi.post('/categorias', data);
      final newCategory = Categoria.fromJson(json);

      categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      throw Exception('Error al insertar');
    }
  }


  Future<void> updateCategory(String id, String name) async {
    final data = {
      "nombre" : name
    };

    try {
      await CafeApi.put('/categorias/$id', data);
      categories = this.categories.map(
        (category) {
          if ( category.id != id ) return category;
          category.nombre = name;
          return category;
        }
      ).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Error al actualizar');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await CafeApi.delete('/categorias/$id');
      categories.removeWhere((categoria) => categoria.id == id );
      notifyListeners();
    } catch (e) {
      throw Exception('Error al eliminar');
    }
  }

}