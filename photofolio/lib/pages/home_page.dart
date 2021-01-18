


import 'dart:io';

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


const introduceMyself ='flutter를 이용한 hybrid app과 kotlin, java를 이용한 native app개발에 관심이 많은 신입 개발자 이시헌입니다!\n'+
'주요 모바일 앱 개발로 포트폴리오 전시 서비스와 학교 심리상담실 예약 솔루션의 모바일 담당,'+
'스마트폰으로 조종하는 웹게임의 android담당 개발을 했습니다.\n'+
'포트폴리오 전시 서비스를 개발하며 REST API 서버 개발을 병행하며 Flutter를 이용한 PWA개발을 진행중이며'+
'학교심리상담 센터 예약 솔루션을 개발하며 Flutter의 WebView와 FCM 푸시알림 서비스를 다뤄봤고 웹 게임의'+
'컨트롤러를 만들면서 SurfaceView와 ScrollView등 다양한 Layout을 만들어보고 Socket.io를 이용한 웹 과의 연동과'+ 
'firebase realtime database를 다뤄봤습니다.';



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
    EdgeInsets textMargin;

    print(MediaQuery.of(context).size.width);

    if(MediaQuery.of(context).size.width>800){
      crossAxisCount =3;
      textMargin = EdgeInsets.fromLTRB(200, 100, 200, 100);
    }      
    else{
      crossAxisCount=2;
      textMargin=EdgeInsets.fromLTRB(70, 30, 70, 30);
    }
      

    return SingleChildScrollView(
      
      child: Column(
        children: [
          Container(
            margin: textMargin,
            child: Text(
              introduceMyself,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            width: 800,
            child: Center(
              child: FutureBuilder<List<Post>>(
                future: fetchPost(),
                builder: (context, snapshot){
                  return snapshot.hasData ? buildGrid(snapshot.data,context,postProvider) : CircularProgressIndicator();
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
          // showPostDialog(context);
          if(MediaQuery.of(context).size.width>710){
            showPostDialog(context);
          }
          else{
            Navigator.pushNamed(context, routePost);
          }
        },
      ),
    );

  }

  showPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.pink[500].withAlpha(30),
      barrierLabel: "show post page dialog" ,
      transitionDuration: new Duration(seconds: 1),
      
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        
        return AlertDialog(
          elevation: 10,

          contentPadding: EdgeInsets.zero,
          content: 
          Container(
            // width: MediaQuery.of(context).size.width*0.6,
            width: 700,
            child: PostPage(),
          )
        );
      }

    );
  }
  

  

  

}

  

