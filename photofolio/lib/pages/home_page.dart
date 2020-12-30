
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

  String baseUrl="http://localhost:8080/api/home";
  

  //Future<List<dynamic>> posts;

  Future<List<dynamic>> fetchPost() async{
    List<Post> ppap = List<Post>();

    FormData formData = FormData.fromMap({
      'search' : 'home'
    });

    Dio dio = Dio();
    var response = await dio.post(baseUrl, data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType)
    print(response.statusCode.toString());
    
    if(response.statusCode==200){
      
      print(response.data.runtimeType);
      var data = response.data as Map<String, dynamic>;
      List<Post> posts = List<Post>();
      data.forEach((key, value) {
        print(key.toString());
        posts.add(new Post(id: value['id'],
          postTitle: value['title'],
          postThumbNail: value['thumbnail'],
          userNickname: value['nickname'],
          postExplain: value['explanation'],
          postLink: value['link']
        ));
      });
      print(posts[0].postTitle);
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
        
      },
    );    
  }
  

  
  


  Widget buildCard(BuildContext context, int index){
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(20),      
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ListTile(
              //title: Text(posts[index].title),
              title: Text('fsd'),
              subtitle: Text(
                //posts[index].nickname,
                'dad',
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image(
                image: Image.network('https://picsum.photos/250?image=9',fit: BoxFit.fill,).image,
                //image: posts[index].thumbNail.image,
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
  

  Future<void> showSettingDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      
      barrierColor: Colors.blue.withAlpha(70),
      transitionDuration: new Duration(milliseconds: 400),
      //barrierDismissible: false,
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        return AlertDialog(
          elevation: 10,
          //backgroundColor: Colors.yellow,
         // contentPadding: EdgeInsets.zero,
          // content: Container(
          //   width: MediaQuery.of(context).size.width*0.4,
          //   child: LoginPage(),
          // )
          content: Container(
            width: MediaQuery.of(context).size.width*0.3,
            child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            //width: MediaQuery.of(context).size.width*0.4,
            child: Column(
              children: [
                Align(
                  child: IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.cancel_outlined,),
                      onPressed: () => Navigator.of(context).pop(),
                  ), 
                  alignment: FractionalOffset(1, 0),
                ),
                //LoginPage(u)
              ],
            ),
          ),
          )
        );
      }

    );
  }



  Future<void> showSettingsDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      
      barrierColor: Colors.blue.withAlpha(70),
      transitionDuration: new Duration(milliseconds: 400),
      //barrierDismissible: false,
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        return AlertDialog(
          elevation: 10,
          content: Container(
            width: double.infinity,
            child: SingleChildScrollView(
            //padding: EdgeInsets.zero,
            //width: MediaQuery.of(context).size.width*0.4,
            child: Column(
              children: [
                Align(
                  child: IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.cancel_outlined,),
                      onPressed: () => Navigator.of(context).pop(),
                  ), 
                  alignment: FractionalOffset(1, 0),
                ),
                FlatButton(
                  child: Text("agagsggs"),
                  onPressed: (){print("ff");},
                ),
                RaisedButton(
                  child: Text('agsg'),
                  onPressed: (){print("agsg");},
                )
                
              ],
            ),
          ),
          )
        );
      }

    );
  }
  

}

  

