import 'dart:typed_data';
import 'dart:convert';

class Post{
  Uint8List thumbNail;
  String title;
  String content;
  List<Uint8List> postImages;

  Post({this.title,this.content,this.thumbNail,this.postImages});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      title:json['title'],
      content:json['password'],
      thumbNail:json['thumbNail'],
      postImages:json['postImages'],
    );
  }

  String toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['title']=this.title;
    data['content']=this.content;
    data['thumbNail']=this.thumbNail;
    data['postImages']=this.postImages;
    var jsonData=json.encode(data);
    return jsonData;
  }
}
