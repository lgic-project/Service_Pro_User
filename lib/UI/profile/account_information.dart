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

class AccountInformationPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String profile;

  const AccountInformationPage(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.profile})
      : super(key: key);

  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  final Color primaryColor = const Color(0xFF43cbac);
  final Color secondaryColor = const Color(0xFFf5f5f5);
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String? _profileImage;

  @override
  void initState() {
    super.initState();
    _profileImage = widget.profile;
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone.toString());
    _addressController = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor,
                backgroundImage: NetworkImage(_profileImage ?? ''),
              ),
              const SizedBox(height: 30),
              _buildEditableField(
                leadingIcon: Icons.person,
                controller: _nameController,
                title: widget.name,
              ),
              _buildEditableField(
                leadingIcon: Icons.email,
                controller: _emailController,
                title: widget.email,
              ),
              _buildEditableField(
                leadingIcon: Icons.phone,
                controller: _phoneController,
                title: widget.phone.toString(),
              ),
              _buildEditableField(
                leadingIcon: Icons.home,
                controller: _addressController,
                title: widget.address,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Call updateUserDetails function here
                  UpdateUserDetails().updateUserDetails(
                    context,
                    _nameController.text,
                    _addressController.text,
                    _phoneController.text,
                  );
                },
                child: const Text('Save', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required IconData leadingIcon,
    required TextEditingController controller,
    required String title,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: primaryColor),
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
          ),
        ),
      ),
    );
  }
}
