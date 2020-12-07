import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:photofolio/store/User.dart';


class UserLogin with ChangeNotifier {

  bool _isLogin =false;
  User _me;
  String _email ="";
  String _pwd="";
  String _nickname=""; // 이름으로 쓰일거에요!
  String _infoText=""; // 간략하게 자신을 소개 하는 글을 작성해요!

  bool getIsLogin() => _isLogin;
  String getEmail() => _email;
  String getPw() => _pwd;
  String getNickName()=>_nickname;
  String getInfoText()=>_infoText;

  User getMe()=>_me;
  String baseUrl="http://localhost:8080/api";

  void login(String email, String pwd) async{
    final res=await http.post(baseUrl+"/login",
    body:json.encode({'eMail':email,'password':pwd}),
    headers: {'Content-Type':'application/json'});

    Map<String,dynamic> map; 

    if(res.body.isEmpty){

    }else{
      map=Map.castFrom(json.decode(res.body));
      _me=User.fromJson(map);
      

      _isLogin = !_isLogin;
      print(User.infoPrint(_me));
      print("^^^^^^^^^^^^"+ getIsLogin().toString());
    }

    
    notifyListeners();
  }
  



}