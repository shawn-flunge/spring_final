import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:photofolio/store/User.dart';


class UserProvider with ChangeNotifier {

  User _me;
  User _friend;

  User getMe()=>_me;
  User getFreind()=>_friend;
  void setFreindNull() => _friend = null;
  
  void visitAbout(String nickname) async{

    Map<String,dynamic> map;
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'nickname' : nickname
    });

    final response = await dio.post(baseUrl+'/visit',data: formData);

    if(response.statusCode ==200)
    {
      var data = response.data;
      map=Map.castFrom(data);
      _friend=User.fromJson(map);
    }

    notifyListeners();
  }

  void login(String email, String pwd) async{
    final res=await http.post(baseUrl+"/login",
      body:json.encode({'eMail':email,'password':pwd}),
      headers: {'Content-Type':'application/json'}
    );

    Map<String,dynamic> map; 

    if(res.body.isEmpty){

    }else{
      //utf8.decode -> jsonDecode 과정 안거치면 한글 깨짐
      var decodeData = utf8.decode(res.bodyBytes);
      var data = jsonDecode(decodeData);
      map = Map.castFrom(data);
      _me=User.fromJson(map);

      print(User.infoPrint(_me));
    }

    
    notifyListeners();
  }



}