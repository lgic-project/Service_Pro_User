import 'package:flutter/material.dart';
import 'package:service_pro_user/UI/booking/booking.dart';
import 'package:service_pro_user/UI/chat_screen/chat_screen.dart';
import 'package:service_pro_user/UI/home_screen/home_screen.dart';
import 'package:service_pro_user/UI/profile/profile_page.dart';

class NavigatorScaffold extends StatefulWidget {
  const NavigatorScaffold({super.key});

  @override
  State<NavigatorScaffold> createState() => _NavigatorScaffoldState();
}

class _NavigatorScaffoldState extends State<NavigatorScaffold> {
  int currentIndex = 0;
  Color? unSelectedItemColor = Colors.white;
  Color? selectedItemColor = Colors.pink[900];
  late Widget currentBody;

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        currentBody = HomeScreen();

        break;
      case 1:
        currentBody = Chat();

        break;
      case 2:
        currentBody = Booking();
        break;
      case 3:
        currentBody = ProfilePage();
        break;
    }
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Service Pro'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: currentBody,
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).primaryColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      height: 30,
                      color: currentIndex == 0
                          ? selectedItemColor
                          : unSelectedItemColor,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/chat.png',
                        height: 30,
                        color: currentIndex == 1
                            ? selectedItemColor
                            : unSelectedItemColor),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/booking.png',
                        height: 30,
                        color: currentIndex == 2
                            ? selectedItemColor
                            : unSelectedItemColor),
                    label: 'Booking',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/profile.png',
                        height: 30,
                        color: currentIndex == 3
                            ? selectedItemColor
                            : unSelectedItemColor),
                    label: 'Profile',
                  ),
                ],
                currentIndex: currentIndex,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unSelectedItemColor,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}