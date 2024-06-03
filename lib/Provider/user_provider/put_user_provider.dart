import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/login_logout_provider.dart';

class UpdateUserDetails with ChangeNotifier {
  Future<void> updateUserDetails(
    BuildContext context,
    String name,
    String address,
    String phone,
  ) async {
    try {
      final token =
          Provider.of<LoginLogoutProvider>(context, listen: false).token;
      final response = await http.put(
        Uri.parse('http://20.52.185.247:8000/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'Name': name,
          'Address': address,
          'PhoneNo': phone,
        }),
      );
      if (response.statusCode == 200) {
        print('User updated successfully: ${response.body}');
      } else {
        print('Error updating user: ${response.body}');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}
