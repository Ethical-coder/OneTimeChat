import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';
//import 'package:http/http.dart' as http;
//import '../Provider/info_data_provider.dart';
//import 'dart:convert' as convert;
import 'package:one_time_chat/Provider/services_data.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController message = TextEditingController();
    //var ref = Provider.of<Info>(context);
    var _db = Provider.of<Services>(context);
    Future<void> sendMessage() async {
      if (message.text.length == 0) {
        Toast.show("No message to send", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      } else if (email.text.length == 0) {
        Toast.show("Enter the Email", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      } else {
        await _db.send_msg(email.text, message.text);
        email.text = "";
        message.text = "";
        Toast.show("Message Sent", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blueGrey);
      }

      print("sending mesage");
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey.shade900,
      child: Container(
        color: Colors.blueGrey.shade600,
        margin: EdgeInsets.only(right: 30, left: 30, top: 150, bottom: 150),
        child: Container(
          margin: EdgeInsets.all(5),
          color: Colors.blueGrey.shade900,
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Send Message",
                  style: TextStyle(fontSize: 30, color: Colors.amberAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 40),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey.shade600),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Enter Receiver Email",
                      hintStyle: TextStyle(color: Colors.blueGrey.shade600)),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey.shade600),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: message,
                  decoration: InputDecoration(
                      hintText: "Enter Message",
                      hintStyle: TextStyle(color: Colors.blueGrey.shade600)),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 10, right: 20),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => sendMessage(),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.send_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
