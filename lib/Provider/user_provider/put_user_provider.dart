import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/login_logout_provider.dart';

class UpdateUserDetails with ChangeNotifier {
  Future<bool> updateUserDetails(
    BuildContext context,
    String name,
    String address,
    String phone,
    String imageUrl,
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
        body: jsonEncode(<String, dynamic>{
          'Name': name,
          'Address': address,
          'PhoneNo': phone,
          'Image': imageUrl.isNotEmpty ? [imageUrl] : [],
        }),
      );
      if (response.statusCode == 200) {
        print('User updated successfully: ${response.body}');
        notifyListeners();
        return true;
      } else {
        print('Error updating user: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception updating user: $e');
      return false;
    }
  }

  Future<String?> uploadProfileImage(
      BuildContext context, String filePath) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://20.52.185.247:8000/upload/file'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return responseData;
      } else {
        print(
            'Error uploading image: ${response.statusCode} ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception uploading image: $e');
      return null;
    }
  }
}
