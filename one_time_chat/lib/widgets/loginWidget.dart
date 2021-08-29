import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:one_time_chat/DataModels/messages.dart';
import 'package:one_time_chat/Provider/services_data.dart';
import 'package:provider/provider.dart';
import '../Provider/info_data_provider.dart';
import 'dart:convert' as convert;
import "package:toast/toast.dart";

class LoginWidget extends StatelessWidget {
  //var _auth = Auth();
  Future<void> process(ref, ser) async {
    await ser.fetch_data();
    await ref.setData(ser.get_data());
    await ref.seperateMsg();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    var ref = Provider.of<Info>(context);
    var _auth = Provider.of<Services>(context);

    //function used for logging into the account
    void loginClicked() async {
      //int q = await _auth.login(email.text, password.text);
      int q = await _auth.login(email.text, password.text);
      print("result");
      print(q);
      if (q == 1) {
        ref.reset();
        _auth.reset();
        await process(ref, _auth);

        Navigator.pushNamed(context, "/mainPage");
        await _auth.delete();
        Toast.show("logged in", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      } else {
        Toast.show("Invalid user", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      }
    }

    return Container(
      height: 450,
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
                  "Login",
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
                      onTap: () => Navigator.pushNamed(context, "/signup"),
                      child: Text("Not Registered?",
                          style: TextStyle(color: Colors.blue.shade200)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: InkWell(
                        onTap: () => {loginClicked()},
                        child: Text(
                          "Login",
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
