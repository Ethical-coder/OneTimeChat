import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_database/firebase_database.dart";
import '../DataModels/messages.dart';
import '../DataModels/messages.dart';

class Services {
  late dynamic data_map;
  late FirebaseAuth _auth;
  late var _db;
  late String email;
  //data variable
  late List<MessageModel> _data = [];
  Services(context) {
    this._auth = FirebaseAuth.instance;
    this._db = FirebaseDatabase.instance.reference();
  }
  void reset() {
    this._data = [];
  }

  //login with email and password
  Future<int> login(String e, String p) async {
    try {
      var result =
          await _auth.signInWithEmailAndPassword(email: e, password: p);

      var user = result.user;
      if (user == null) {
        return 0;
      }

      this.email = e;
      return 1;
    } on FirebaseAuthException catch (e) {
      return 0;
    }
  }

  //register with email
  Future<int> signup(String e, String p) async {
    try {
      var _ = await _auth.createUserWithEmailAndPassword(email: e, password: p);

      this.email = e;
      return 1;
    } on FirebaseAuthException catch (e) {
      return 0;
    }
  }

  //add message to firebase realtime database
  Future<void> send_msg(String rec, String msg) async {
    try {
      String receiver = "";
      for (var i = 0; i < rec.length; i++) {
        if (rec[i] == '@') break;
        receiver = receiver + rec[i];
      }
      await _db
          .child(receiver)
          .push()
          .set({"email": this.email, "message": msg});
    } catch (e) {
      print(e);
    }
  }

  //fetch all the message in the database
  Future<dynamic> fetch_data() async {
    String e = "";
    for (var i = 0; i < this.email.length; i++) {
      if (this.email[i] == '@') break;
      e = e + this.email[i];
    }
    try {
      await _db.once().then((DataSnapshot ds) {
        this.data_map = ds.value[e];
      });
      for (var i in this.data_map.keys) {
        _data.add(MessageModel(
            this.data_map[i]["email"], this.data_map[i]["message"]));
      }
    } catch (e) {
      print(e);
      print("error in fetching data");
    }
  }

  // function to delete data after opening
  Future<void> delete() async {
    String e = "";
    for (var i = 0; i < this.email.length; i++) {
      if (this.email[i] == '@') break;
      e = e + this.email[i];
    }
    try {
      await _db.child(e).remove();
    } catch (e) {
      print(e);
    }
  }

  //return captured data
  List<MessageModel> get_data() {
    return [..._data];
  }
}
