import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    TextEditingController msg = TextEditingController();
    var ref = Provider.of(context);
    void sendFunction() async {
      var url = Uri.http(ref.url, "/send_msg", {'q': '{http}'});
      var response = await http.post(url, body: {
        "sender": ref.number,
        "receiver": data["num"].text,
        "message": msg.text
      });
      var resBody = convert.jsonDecode(response.body);
      if (resBody['status'] == 'success') {
        print("success");
      } else {
        print("failed");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data["name"]),
        backgroundColor: Colors.blueGrey.shade600,
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(bottom: 70),
        color: Colors.blueGrey.shade900,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: ScrollController(
              initialScrollOffset: MediaQuery.of(context).size.height),
          itemCount: data["msg"].length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(data["msg"][index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  )),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 80),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.shade800),
            );
          },
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        color: Colors.blueGrey.shade900,
        padding: EdgeInsets.only(bottom: 15, top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    controller: msg,
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.blueGrey.shade400)),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 125),
              InkWell(
                onTap: () => {sendFunction()},
                child: Icon(
                  Icons.send_sharp,
                  color: Colors.lightBlue.shade800,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
