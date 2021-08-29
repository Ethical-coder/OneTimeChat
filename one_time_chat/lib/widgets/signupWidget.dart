import 'package:flutter/material.dart';
import 'package:one_time_chat/Provider/info_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:one_time_chat/Provider/services_data.dart';
//import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:toast/toast.dart';

class SignupWidget extends StatelessWidget {
  void navigateToLogin(ctx) {
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Services>(context);
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    var ref = Provider.of<Info>(context);

    Future<void> signupClicked(ctx) async {
      var x = await _auth.signup(email.text, password.text);
      if (x == 1) {
        Toast.show("User Created", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
        Navigator.pop(ctx);
      } else {
        Toast.show("Invalid Credentials", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      }
    }

    return Container(
      height: 550,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30),
      color: Colors.blueGrey[500],
      alignment: Alignment.topRight,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.left,
                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, top: 20)),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 50),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: "Enter Your Email Address",
                    hoverColor: Colors.white),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 50),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "Enter Your Name", hoverColor: Colors.white),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 50),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    hintText: "Enter Your Password", hoverColor: Colors.white),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, top: 50, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => navigateToLogin(context),
                      child: Text("Already Registered?",
                          style: TextStyle(color: Colors.blue.shade200)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: InkWell(
                        onTap: () => signupClicked(context),
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(5),
        color: Colors.blueGrey[800],
      ),
    );
  }
}
