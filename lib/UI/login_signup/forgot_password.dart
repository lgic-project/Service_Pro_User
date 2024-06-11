import 'package:flutter/material.dart';
import 'package:service_pro_user/UI/login_signup/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
          )),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forgot Password?',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your email to reset password',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CodeVerificationScreen(
                            email: emailController.text)));
              },
              child: Text('Reset Password'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeVerificationScreen extends StatelessWidget {
  final String email;
  const CodeVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Verification Code',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter the code sent to your email',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Verification Code',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewPasswordSet()));
              },
              child: Text('Verify Code'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPasswordSet extends StatelessWidget {
  const NewPasswordSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Set New Password',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your new password',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Text('Set New Password'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
