

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:photofolio/store/post.dart';




class PostProvider with ChangeNotifier{

  String _keyWord;
  Post _selectedPost;
  List<Post> _posts = List<Post>();

  String getKeyWord() => _keyWord;
  Post getSelectedPost() => _selectedPost;
  List<Post> getPosts() => _posts;

  void selectPost(Post post){
    _selectedPost = post;
    notifyListeners();
  }

  void fetchPost() async{
    print('start fetch');
    FormData formData = FormData.fromMap({
      'search' : '한글'
    });
    Dio dio = Dio();

    var response = await dio.post(baseUrl+'/home', data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType, responseType: ResponseType.plain)
 
    if(response.statusCode==200){  
      var data = response.data as Map<String, dynamic>;

      data.forEach((key, value) {
        print(value['thumbnail']);
        var thumbnail = value['thumbnail'].toString().split('/');
        var realThumbnail = imageUrl+'/' + thumbnail[9];
        _posts.add(new Post(id: value['id'],
          postTitle: value['title'],
          postThumbNail: realThumbnail,
          userNickname: value['nickname'],
          postExplain: value['explanation'],
          postLink: value['link']
        ));
        
      });
      
    }

    notifyListeners();
  }



}