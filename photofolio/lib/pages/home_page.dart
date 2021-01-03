
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/post_page.dart';

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

  String baseUrl="https://rest-api-server-axfra.run.goorm.io/api/home";
  

  //Future<List<dynamic>> posts;

  Future<List<Post>> fetchPost() async{
    print('start fetch');
    FormData formData = FormData.fromMap({
      'search' : '한글'
    });

    Dio dio = Dio();


    var response = await dio.post(baseUrl, data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType, responseType: ResponseType.plain)
    print(response.statusCode.toString());
 

    if(response.statusCode==200){
      
      print(response.data.runtimeType.toString() +'///');
      //jsonDecode(utf8.decode(response.data));
      var data = response.data as Map<String, dynamic>;
      //var data = rr as Map<String, dynamic>;

      List<Post> posts = List<Post>();
      print(posts.length.toString() + "fsfsdf");

      data.forEach((key, value) {
        print(value['thumbnail']);
        var thumbnail = value['thumbnail'].toString().split('/');
        var real_thumbnail = 'https://rest-api-server-axfra.run.goorm.io/'+'/' + thumbnail[7] + '/' +thumbnail[8]+ '/'+thumbnail[9];
        posts.add(new Post(id: value['id'],
          postTitle: value['title'],
          postThumbNail: real_thumbnail,
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
    UserLogin userLogin = Provider.of<UserLogin>(context);
    

    if(MediaQuery.of(context).size.width>700)
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

          // RaisedButton(
          //   child: Text('show Edit post'),
          //   onPressed: () { showEditPostDialog(context);}
          // ),
          // RaisedButton(
          //   child: Text('settings'),
          //   onPressed: () { 
          //     showSettingsDialog(context);
          //   }
          // ),

          // RaisedButton(
          //   child: Text('editing page'),
          //   onPressed: () { 
          //     Navigator.of(context).push(MaterialPageRoute(builder: (context) { return SignUpPage();}));
          //   }
          // ),
          // RaisedButton(
          //   child: Text('show post'),
          //   onPressed: () { 
          //     showPostDialog(context);
          //   }
          // ),
          Container(
            width: 1000,
            child: Center(
              child: FutureBuilder<List<Post>>(
                future: fetchPost(),
                builder: (context, snapshot){
                  return snapshot.hasData ? buildGrid(snapshot.data,context) : Text('ff');
                  // return buildGrid(snapshot.data,context);
                },
              ),
            ),
          ),
          // Container(
          //   //margin: EdgeInsets.fromLTRB(200, 10, 200, 0),
          //   //padding: EdgeInsets.all(100),
          //   //color: Colors.pink[300],
          //   width: 1000,
          //   // height: double.infinity,
          //   child: Center(
          //     child: GridView.count(
          //       shrinkWrap: true,
          //       crossAxisCount: crossAxisCount,
          //       padding: EdgeInsets.all(10),

          //       children: List<Widget>.generate(posts.length, (index) {
          //         return buildCard(context,index);
          //       })
          //     ),
          //   )
          // ),
          
          //buildCard(context,10)
        ],
      )
    );
  }

  buildGrid(List<Post> posts, BuildContext context){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return buildCard(context, posts[index]);
      },
    );    
  }
  

  
  


  Widget buildCard(BuildContext context, Post post){
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(20),      
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(post.postTitle),
              //title: Text('fsd'),
              subtitle: Text(
                post.userNickname,
                //'dad',
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                // image: Image.network('https://picsum.photos/250?image=9',fit: BoxFit.fill,).image,
                image: Image.network(post.postThumbNail,fit: BoxFit.fill,).image,
                //image: Image.network('https://rest-api-server-axfra.run.goorm.io'+'/static/images/1b539288-ac7a-4247-964a-659f54fe7c0f.png',fit: BoxFit.fill,).image,
                
                width: double.maxFinite,         
              ),
            ),        
          ],
        ),
      ),
      onTap: (){
        showPostDialog(context);
      },
    );

  }

  Future<void> showPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
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

  

