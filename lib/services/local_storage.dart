import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static late SharedPreferences prefs;

  static Future<void> configuratePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}