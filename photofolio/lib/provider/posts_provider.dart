import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:photofolio/store/Post.dart';
class PostList with ChangeNotifier {

  List<Post> posts;

  List<Post> getPosts()=>posts;

  String baseUrl="http://localhost:8080/api/";

  void addPost(Post post) async{
    posts.add(post);

    Uri requestUri = Uri.parse(baseUrl+"/uploadImage");

    String _iamgeString;

    /*
    final imageUploadRequest=http.MultipartRequest('POST',requestUri);
    */

    // final file=await http.MultipartFile.fromPath('images[0]', image.path)

    notifyListeners();
  }
  

}