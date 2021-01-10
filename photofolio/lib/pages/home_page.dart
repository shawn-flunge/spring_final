
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/post_page.dart';
import 'package:photofolio/provider/post_provider.dart';
import 'package:photofolio/routes/routes.dart';

import 'package:photofolio/store/post.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget{

  HomePageState createState() => HomePageState(); 
}



class HomePageState extends State<HomePage> {


  List<Text> tt = List<Text>();
  List<Widget> widgets = List<Widget>();
  var crossAxisCount =0;
  
  Image img = Image.network('https://picsum.photos/250?image=9');

  String baseUrl2="https://rest-api-server-axfra.run.goorm.io/api/home";
  

  //Future<List<dynamic>> posts;

  Future<List<Post>> fetchPost() async{
    print('start fetch');
    FormData formData = FormData.fromMap({
      'search' : '한글'
    });
    Dio dio = Dio();

    var response = await dio.post(baseUrl+'/home', data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType, responseType: ResponseType.plain)
 
    if(response.statusCode==200){  
      print(response.data.runtimeType.toString() +'///');
      var data = response.data as Map<String, dynamic>;

      List<Post> posts = List<Post>();
      data.forEach((key, value) {
        var thumbnail = value['thumbnail'].toString().split('/');
        var realThumbnail = imageUrl+'/' + thumbnail[9];
        posts.add(new Post(id: value['id'],
          postTitle: value['title'],
          postThumbNail: realThumbnail,
          userNickname: value['nickname'],
          postExplain: value['explanation'],
          postLink: value['link']
        ));
        
      });
      
      return posts;
    }
  }

  
  

  @override
  Widget build(BuildContext context){
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PostProvider postProvider = Provider.of<PostProvider>(context);
    userProvider.setFreindNull();

    // Future<List<Post>> postss = postProvider.posts;
    if(MediaQuery.of(context).size.width>800)
      crossAxisCount =3;
    else
      crossAxisCount=2;

    return SingleChildScrollView(
      
      child: Column(
        children: [
          Text(
            'Home Page',
            style: TextStyle(fontSize: 30),
          ),
          Container(
            width: 800,
            child: Center(
              child: FutureBuilder<List<Post>>(
                future: fetchPost(),
                builder: (context, snapshot){
                  return snapshot.hasData ? buildGrid(snapshot.data,context,postProvider) : Text('ff');
                  // return buildGrid(snapshot.data,context);
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  buildGrid(List<Post> posts, BuildContext context, PostProvider postProvider){
    return GridView.builder(
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return buildCard(context, posts[index], postProvider);
      },
    );    
  }
  

  
  


  Widget buildCard(BuildContext context, Post post, PostProvider postProvider){
    return Container(
      //margin: EdgeInsets.all(50),
      //padding: EdgeInsets.all(50),
      child: InkWell(
        child: Card(
          margin: EdgeInsets.all(20),      
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(post.postTitle),
                subtitle: Text(
                  post.userNickname,
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image(
                  image: Image.network(post.postThumbNail,fit: BoxFit.fill,).image,
                  width: double.maxFinite,         
                ),
              ),        
            ],
          ),
        ),
        onTap: (){
          print(post.id.toString() + "###################");
          postProvider.selectPost(post);
          showPostDialog(context);
        },
      ),
    );

  }

  Future<void> showPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.pink[500].withAlpha(30),
      barrierLabel: "ff" ,
      transitionDuration: new Duration(seconds: 1),
      
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        
        return AlertDialog(
          elevation: 10,
       
          contentPadding: EdgeInsets.zero,
          content: 
          Container(
            width: MediaQuery.of(context).size.width*0.6,
            child: PostPage(),
          )
        );
      }

    );
  }
  

  

  

}

  

