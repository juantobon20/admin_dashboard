import 'package:flutter/material.dart';

class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Future<Object?> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<Object?> replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  } 
}