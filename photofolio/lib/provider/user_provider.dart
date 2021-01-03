import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:photofolio/store/User.dart';


class UserLogin with ChangeNotifier {

  bool _isLogin =false;
  User _me;

  bool getIsLogin() => _isLogin;
  User getMe()=>_me;
  //String baseUrl="https://rest-api-server-axfra.run.goorm.io/api";

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

  void visit(String str){
    
  }
  



}