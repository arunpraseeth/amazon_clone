import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    name: "",
    email: "",
    password: "",
    address: "",
    type: "",
    token: "",
  );

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  User get user => _user;
}
