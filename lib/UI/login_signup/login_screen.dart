import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/login_logout_provider.dart';
import 'package:service_pro_user/UI/login_signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginLogoutProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('SERVICE PRO'),
        backgroundColor: Color(0xFF43cbac),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Container(
        height: screenHeight - appBarHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF43cbac), Color(0xFF006d77)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                buildInputField(_emailController, 'Email Address', Icons.email),
                SizedBox(height: 10),
                buildInputField(
                  _passwordController,
                  'Password',
                  Icons.lock,
                  isPasswordField: true,
                  isPasswordVisible: _isPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await userProvider.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    // Check if the login was successful
                    if (userProvider.isLoggedIn) {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Invalid email or password'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: userProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF43cbac),
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF43cbac),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
      TextEditingController controller,
      String labelText,
      IconData icon, {
        bool isPasswordField = false,
        bool isPasswordVisible = false,
        Function()? onVisibilityToggle,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField && !isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFF43cbac)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPasswordField
            ? IconButton(
          onPressed: onVisibilityToggle,
          icon: isPasswordVisible
              ? Icon(Icons.visibility, color: Color(0xFF43cbac))
              : Icon(Icons.visibility_off, color: Color(0xFF43cbac)),
        )
            : null,
      ),
    );
  }
}