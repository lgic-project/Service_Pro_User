import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/profile_provider.dart';
import 'package:image_picker/image_picker.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(1), secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: primaryColor,
                      backgroundImage: NetworkImage(_profileImage ?? ''),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _profileImage = image.path;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child:
                                Icon(Icons.edit, color: primaryColor, size: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  title: widget.phone,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Save the changes
                  },
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
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
