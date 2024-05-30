import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/login_logout_provider.dart';
import 'package:service_pro_user/Provider/profile_provider.dart';
import 'package:service_pro_user/UI/login_signup/login_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).userProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginLogoutProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
          child: Consumer<ProfileProvider>(builder: (context, profile, child) {
        var user = profile.data;
        final profilePic = (user['Image'] ??
            'https://dudewipes.com/cdn/shop/articles/gigachad.jpg?v=1667928905&width=2048');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profilePic.toString()),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user['Name'] ?? 'User Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    user['Email'] ?? 'User Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}
