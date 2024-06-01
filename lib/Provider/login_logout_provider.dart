import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogoutProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String _token = '';
  String _userId = '';
  bool _verified = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String get token => _token;
  String get userId => _userId;
  bool get verified => _verified;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://20.52.185.247:8000/user/login'),
        body: jsonEncode({
          'Email': email,
          'Password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null && data['data'] != null) {
          final userData = data['data'];
          _token = userData['token'];
          _userId = userData['_id'] ?? ''; // Use _userId = '' if _id is null
          _verified = userData['Verified'] == true; // Ensure boolean type

          if (userData['Role'] == 'user') {
            await storeToken(_token);
            _isLoggedIn = true;
          } else {
            print('Error: Invalid role');
            _isLoggedIn = false;
          }
        } else {
          print('Error: Invalid response format');
          _isLoggedIn = false;
        }
      } else {
        print('Error: ${response.body}');
        _isLoggedIn = false;
      }
    } catch (e) {
      print('Error: $e');
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = '';
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    _isLoggedIn = _token.isNotEmpty;
    notifyListeners();
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
