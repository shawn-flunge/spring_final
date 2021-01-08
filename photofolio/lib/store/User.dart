import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:photofolio/routes/routes.dart';

class User{
  String eMail;
  String password;
  String nickname;
  String infoText;
  String imgPath;

  User({this.eMail,this.password,this.nickname,this.infoText,this.imgPath});

  static infoPrint(User user){
    print('email '+user.eMail);
    print('password '+user.password);
    print('nick '+user.nickname);
    print('infoText '+user.infoText);
    print('imgPath '+user.imgPath);
  }
  factory User.fromJson(Map<String,dynamic> json){
    String img;
    String info;

    if(json['imgPath'] == null)
      img = 'https://rest-api-server-axfra.run.goorm.io/static/images/default.png';
    else
      img =imageUrl+'/' +json['imgPath'].toString().split('/')[9];
    
    if(json['infoText'] == null)
      info='';
    else
      info = json['infoText'];

    return User(
      eMail:json['eMail'],
      password:json['password'],
      nickname:json['nickname'],
      infoText:info,
      imgPath:img
    );
  }
  String toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['eMail']=this.eMail;
    data['password']=this.password;
    data['nickname']=this.nickname;
    var jsonData=json.encode(data);
    return jsonData;
  }
  
}