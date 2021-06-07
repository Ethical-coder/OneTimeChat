import 'package:flutter/material.dart';
import 'package:one_time_chat/screens/mainScreen.dart';
import 'package:provider/provider.dart';
import './screens/login.dart';
import './screens/signup.dart';
import './screens/mainScreen.dart';
import './screens/contactScreen.dart';
import './Provider/info_data_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Info(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (ctx) => Login(),
          '/signup': (ctx) => Signup(),
          "/mainPage": (ctx) => ChatScreen(),
          "/contact": (ctx) => ContactScreen()
        },
      ),
    );
  }
}
