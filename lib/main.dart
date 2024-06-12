import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/category_and_service_provider/service_provider.dart';
import 'package:service_pro_user/Provider/category_provider.dart';
import 'package:service_pro_user/Provider/chat_user_provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/login_logout_provider.dart';
import 'package:service_pro_user/Provider/login_signup_provider/signup_provider.dart';
import 'package:service_pro_user/Provider/search_provider/service_search_provider.dart';
import 'package:service_pro_user/Provider/search_provider/user_search_provider.dart';
import 'package:service_pro_user/Provider/serviceRequest_provider/get_service_request_provider.dart';
import 'package:service_pro_user/Provider/serviceRequest_provider/serviceRequest_provider.dart';
import 'package:service_pro_user/Provider/user_provider/change_password_provider.dart';
import 'package:service_pro_user/Provider/user_provider/profile_provider.dart';
import 'package:service_pro_user/Provider/user_provider/put_user_provider.dart';
import 'package:service_pro_user/Provider/user_provider/reset_password_provider.dart';
import 'package:service_pro_user/UI/Navigator/navigator_scaffold.dart';
import 'package:service_pro_user/UI/password_reset/forgot_password_screen.dart';
import 'package:service_pro_user/UI/login_signup/login_screen.dart';
import 'package:service_pro_user/UI/settings/widgets/active_status.dart';
import 'package:service_pro_user/UI/settings/widgets/change_password.dart';
import 'package:service_pro_user/UI/splash_screen/splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => LoginLogoutProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ChatUserProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserDetails()),
        ChangeNotifierProvider(create: (_) => SearchService()),
        ChangeNotifierProvider(create: (_) => UserSearchProvider()),
        ChangeNotifierProvider(create: (_) => ServiceRequestProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => GetServiceRequest()),
        ChangeNotifierProvider(create: (_) => ResetPassword()),
        ChangeNotifierProvider(create: (_) => ChangePassword()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF43cbac),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/dashboard': (context) => const NavigatorScaffold(),
          '/login': (context) => const LoginScreen(),
          '/forgotPassword': (context) => const ForgotPasswordScreen(),
          '/active_status': (context) => const ActiveStatus(),
          '/change_password': (context) => const ChangePasswordScreen(),
        },
      ),
    );
  }
}
