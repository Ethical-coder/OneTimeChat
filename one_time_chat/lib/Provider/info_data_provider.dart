import '../DataModels/messages.dart';

class Info {
  String _userEmail = "";
  String _userName = "";
  List<MessageModel> data = [];
  Map<String, Map<String, dynamic>> _processded_data = {};
  void reset() {
    this.data = [];
    this._processded_data = {};
    this._userEmail = "";
    this._userName = "";
  }

  String get email {
    return _userEmail;
  }

  String get name {
    return _userName;
  }

  void setEmail(email) {
    _userEmail = email;
  }

  List<MessageModel> get fetchData {
    return [...data];
  }

  void setData(value) {
    this.data = value;
  }

  void seperateMsg() {
    var data = [...this.data];
    Map<String, Map<String, dynamic>> newData = {};
    var i = 0;

    for (; i < data.length; i++) {
      var check = 0;
      var keys = [...newData.keys];
      var j = 0;
      for (; j < keys.length; j++) {
        if (data[i].senderEmail == keys[j]) {
          check = 1;
          break;
        }
      }

      if (check == 0) {
        Map<String, Map<String, dynamic>> appData = {
          data[i].senderEmail: {
            'count': 1,
            'msg': [data[i].message],
          }
        };
        newData.addAll(appData);
      } else {
        newData[data[i].senderEmail]!['count'] += 1;
        newData[data[i].senderEmail]!['msg'].add(data[i].message);
      }
    }
    _processded_data = newData;
  }

  Map<String, Map<String, dynamic>> get processedData {
    return {..._processded_data};
  }
}
