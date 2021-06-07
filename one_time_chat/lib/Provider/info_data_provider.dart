import 'package:flutter/material.dart';
import '../DataModels/messages.dart';

class Info with ChangeNotifier {
  String _userNum = "";
  String _userName = "";
  String _mainUrl = "";
  List<MessageModel> _data = [
    MessageModel("abhi", "22356456", "my first message"),
    MessageModel("sid", "22356566456", "my 2 message"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456", "my 5 message"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456", "my 5 message"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456", "my 5 message"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456", "my 5 message"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456",
        "my 5 messagddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddRe"),
    MessageModel("abhi", "22356456", "my 3 message"),
    MessageModel("abhi", "22356456", "my 4 message"),
    MessageModel("abhi", "22356456", "my 5 message"),
    MessageModel("sid", "22356566456", "my 2 dfvmessage"),
  ];
  Map<String, Map<String, dynamic>> _processded_data = {};

  String get url {
    return _mainUrl;
  }

  String get number {
    return _userNum;
  }

  String get name {
    return _userName;
  }

  void setUser(number) {
    _userNum = number;
  }

  List<MessageModel> get fetchData {
    return [..._data];
  }

  void setData(value) {
    this._data = value;
  }

  void seperateMsg() {
    var data = [..._data];
    Map<String, Map<String, dynamic>> newData = {};
    var i = 0;

    for (; i < data.length; i++) {
      var check = 0;
      var keys = [...newData.keys];
      var j = 0;
      for (; j < keys.length; j++) {
        if (data[i].senderNumber == keys[j]) {
          check = 1;
          break;
        }
      }

      if (check == 0) {
        Map<String, Map<String, dynamic>> appData = {
          data[i].senderNumber: {
            'count': 1,
            'msg': [data[i].message],
            'name': data[i].senderName
          }
        };
        newData.addAll(appData);
      } else {
        newData[data[i].senderNumber]!['count'] += 1;
        newData[data[i].senderNumber]!['msg'].add(data[i].message);
      }
    }
    _processded_data = newData;
  }

  Map<String, Map<String, dynamic>> get processedData {
    return {..._processded_data};
  }
}
