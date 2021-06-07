import 'package:flutter/material.dart';
import 'package:one_time_chat/Provider/info_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SignupWidget extends StatelessWidget {
  void navigateToLogin(ctx) {
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController number = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    var ref = Provider.of<Info>(context);

    void signupClicked() async {
      var url = Uri.http(ref.url, "/signup", {'q': '{http}'});
      var response = await http.post(url, body: {
        "phone_number": number.text,
        "password": password.text,
        "name": name.text
      });
      var resBody = convert.jsonDecode(response.body);
      if (resBody['status'] == 'success') {
        Navigator.pop(context);
      } else {
        print('unsuccessful signup');
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
                controller: number,
                decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
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
                        onTap: () => signupClicked(),
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
