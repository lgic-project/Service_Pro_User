import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/login_logout_provider.dart';

class SignUpProvider with ChangeNotifier {
  Future<void> signUp(
    String name,
    String email,
    String password,
    String phoneNo,
    String address,
    String image,
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
        'Image': image,
      }),
    );

    if (response.statusCode == 200) {
      print('Sign up successful');
    } else {
      print('Sign up failed: ${response.statusCode}');
      throw Exception('Failed to sign up');
    }
  }

  Future<void> sendVerificationEmail(BuildContext context, String email) async {
    final token =
        Provider.of<LoginLogoutProvider>(context, listen: false).token;
    final response = await http.post(
      Uri.parse('http://20.52.185.247:8000/mail/send/welcome'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',
      },
      body: json.encode({'Email': email}),
    );

    if (response.statusCode == 200) {
      print('Verification email sent');
    } else {
      print(
          'Failed to send verification email: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to send verification email');
    }
  }
}
