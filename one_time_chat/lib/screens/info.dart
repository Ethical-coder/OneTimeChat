import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Text(
        "This App is Designed for One time conversations. Chats won't be stored any where and will be visible to users for One time only.",
        style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 30,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
