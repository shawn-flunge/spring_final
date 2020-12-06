

import 'package:flutter/cupertino.dart';

class UserLogin with ChangeNotifier {

  bool _isLogin =false;
  String _email ="";

  bool getIsLoin() => _isLogin;
  String getEmail() => _email;

  void login(String email, String pwd){

    _email = email;
    _isLogin = !_isLogin;
    notifyListeners();
  }


}