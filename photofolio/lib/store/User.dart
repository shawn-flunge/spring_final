import 'dart:convert';

import 'package:flutter/rendering.dart';

class User{
  String eMail;
  String password;
  String nickname;
  String infoText;

  User({this.eMail,this.password,this.nickname,this.infoText});

  static infoPrint(User user){
    print('email '+user.eMail);
    print('password '+user.password);
    print('nick '+user.nickname);
    //print('infoText '+user.infoText);
  }
  factory User.fromJson(Map<String,dynamic> json){
    return User(
      eMail:json['eMail'],
      password:json['password'],
      nickname:json['nickname'],
      infoText:json['infoText'],
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