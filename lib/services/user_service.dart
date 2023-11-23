import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<void> setUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> setText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('text', text);
  }

  static Future<String?> getText() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('text');
  }
}
