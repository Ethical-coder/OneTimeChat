import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_time_chat/screens/mainScreen.dart';
import 'package:provider/provider.dart';
import './screens/login.dart';
import './screens/signup.dart';
import './screens/mainScreen.dart';
import './screens/contactScreen.dart';
import './Provider/info_data_provider.dart';
import './Provider/services_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Info>(
          create: (ctx) => Info(),
        ),
        Provider<Services>(create: (ctx) => Services(context))
      ],
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
