import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_time_chat/DataModels/messages.dart';
import 'package:provider/provider.dart';
import '../Provider/info_data_provider.dart';
import 'dart:convert' as convert;

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController number = TextEditingController();
    TextEditingController password = TextEditingController();
    var ref = Provider.of<Info>(context);

    void loginClicked() async {
      var url = Uri.http(ref.url, "/login", {'q': '{http}'});
      var response = await http.post(url,
          body: {"phone_number": number.text, "password": password.text});
      var resBody = convert.jsonDecode(response.body);
      if (resBody['status'] == 'success') {
        ref.setUser(number.text);
        Navigator.pushNamed(context, "/mainPage");
      } else {
        print("Unsuccessful login");
      }

      var geturl = Uri.http(
          ref.url, "/get_msg?receiver=" + number.text, {'q': '{http}'});
      var getresp = await http.get(geturl);
      var data = convert.jsonDecode(getresp.body);
      if (data['status' == "success"]) {
        List<MessageModel> model = [];
        for (var i = 0; i < data['msg'].length; i++) {
          MessageModel obj = MessageModel(data['msg'][i]['name'],
              data['msg'][i]['sender'], data['msg'][i]['message']);
          model.add(obj);
        }
        ref.setData(model);
        ref.seperateMsg();

        var delurl = Uri.http(ref.url, "/conv_end?receiver=" + ref.number);
        var _ = await http.get(delurl);
      } else {
        print("failed");
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
