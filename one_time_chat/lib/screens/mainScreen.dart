import 'package:flutter/material.dart';
import '../widgets/chatWidget.dart';
import 'info.dart';
import 'message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var selectedScreen = 0;
  void pagechanger(index) {
    setState(() {
      selectedScreen = index;
    });
  }

  dynamic pageSetter() {
    if (selectedScreen == 0) {
      return Chats();
    } else if (selectedScreen == 1) {
      return Message();
    } else {
      return Info();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("One Time Chat"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Container(color: Colors.blueGrey.shade900, child: pageSetter()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade600,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_sharp,
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.send), label: "Send Message"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Info"),
        ],
        currentIndex: 0,
        onTap: (int index) => pagechanger(index),
      ),
    );
  }
}
