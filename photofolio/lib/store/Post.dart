import 'package:flutter/cupertino.dart';

class Post{
  Image thumbNail;
  String title;
  String content;


  Post({this.title,this.content,this.thumbNail});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      title:json['thumbNail'],
      content:json['password'],
      thumbNail:json['thumbNail'],
    );
  }
}
