import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String name;
  String phone;
  String count;
  List msg;
  CardWidget(this.name, this.phone, this.count, this.msg);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/contact",
          arguments: {"name": this.name, "num": this.phone, 'msg': this.msg}),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade600,
            border: Border.all(color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.attribution,
              color: Colors.amberAccent,
              size: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                children: [
                  Text(
                    this.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                  ),
                  Text(
                    this.phone,
                    style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                this.count.toString(),
                style: TextStyle(fontSize: 15, color: Colors.greenAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
