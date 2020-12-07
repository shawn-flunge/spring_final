

import 'package:flutter/cupertino.dart';
import 'package:photofolio/store/User.dart';
import 'package:http/http.dart';

class UserLogin with ChangeNotifier {

  bool _isLogin =false;
  String _email ="";
  User _user;

  bool getIsLoin() => _isLogin;
  String getEmail() => _email;
  User getUser() => _user;

  void login(String email, String pwd){

    _email = email;
    _isLogin = !_isLogin;
    notifyListeners();
  }


}