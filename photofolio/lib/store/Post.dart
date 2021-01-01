

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Post{

  int id;
  String postTitle;
  String userNickname;
  String postExplain;
  String postLink;
  String postThumbNail;
  
  Post({this.id, this.postTitle, this.userNickname, this.postThumbNail, this.postExplain, this.postLink});

  // List<Post> fromJson(Map<String,dynamic> json){
  //   List<Post> posts;
  //   json.forEach((key, value) {
  //     Post post = Post(id: value["id"],
  //       postTitle: value['title'],
  //       userNickname : value['nickname'],
  //       postThumbNail : value['thumbnail'],
  //       postExplain : value['explanation'],
  //       postLink : value['postLink']
  //     );
  //     posts.add(post);
  //   });
  //   return posts;
  // }

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      id: json['id'],
      postTitle: json['title'] as String,
      userNickname: json['nickname'] as String,
      postThumbNail: json['thumbnail'] as String,
      postExplain: json['explanation'] as String,
      postLink: json['link'] as String,
    );   
  }

  
 


}