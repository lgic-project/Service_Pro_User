import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/category_provider.dart';
import 'package:service_pro_user/Provider/user_provider.dart';
import 'package:service_pro_user/UI/Navigator/navigator_scaffold.dart';
import 'package:service_pro_user/UI/login_signup/login_screen.dart';
import 'package:service_pro_user/UI/splash_screen/splash_screen.dart';
import 'package:service_pro_user/UI/home_screen/widgets/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF43cbac),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/dashboard': (context) => NavigatorScaffold(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
