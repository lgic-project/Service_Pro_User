import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/login');
          }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('User Verification'),),
    );
  }
}
