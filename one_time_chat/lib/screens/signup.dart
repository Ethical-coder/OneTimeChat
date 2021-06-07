import 'package:flutter/material.dart';
import '../widgets/signupWidget.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("One Time Chat"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Container(
        color: Colors.blueGrey.shade900,
        child: ListView(
          children: [SizedBox(height: 100), SignupWidget()],
        ),
      ),
    );
  }
}
