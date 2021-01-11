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
  User getFriend()=>_friend;
  
  Future<void> visitAbout(String nickname) async{
    _friend = null;
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^strat visitAbout');
    Map<String,dynamic> map;
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'nickname' : nickname
    });

    final response = await dio.post(baseUrl+'/visit',data: formData);
    print(response.statusCode);
    if(response.statusCode ==200)
    {
      var data = response.data;
      map=Map.castFrom(data);
      var realThumbnail;

      if(map['imgPath'] == null){
        realThumbnail = 'https://rest-api-server-axfra.run.goorm.io/static/images/default.png';
      } 
      else{
        var thumbnail = map['imgPath'].toString().split('/');
        realThumbnail = imageUrl+'/' + thumbnail[9];
      }

      if(map['infoText'] == null)
        map['infoText']='';

      _friend= User(
        eMail: map['email'],
        password: map['password'],
        nickname: map['nickname'],
        imgPath: realThumbnail,
        infoText: map['infoText']
      );
      print(_friend.imgPath);
    }

    notifyListeners();
  }

  Future<void> login(String email, String pwd) async{
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