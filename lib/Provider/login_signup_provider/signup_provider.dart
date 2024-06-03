import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  Future<void> signUp(
    String name,
    String email,
    String password,
    String phoneNo,
    String address,
    String image, // Change from List<String> to String
  ) async {
    final response = await http.post(
      Uri.parse('http://20.52.185.247:8000/user/signup'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'Name': name,
        'Email': email,
        'Password': password,
        'PhoneNo': phoneNo,
        'Address': address,
        'Image': image, // Change from List<String> to String
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful signup
      print('Sign up successful');
    } else {
      // Handle error
      print('Sign up failed');
      throw Exception('Failed to sign up');
    }
  }
}
