import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/post_page.dart';
import 'package:photofolio/pages/setting_page.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget{
  AboutPageState createState() => AboutPageState();
}



class AboutPageState extends State<AboutPage> {

  TextEditingController introduceController;

  

  List<String> ss = ['ff','gg','ewerqrq','vvv','zzz','qqq','tt'];
  // var ac= <ActionChip>[];
  List<ActionChip> ac = List<ActionChip>();
  


  @override
  Widget build(BuildContext context) {

    for(int i=0;i<ss.length;i++){
      ac.add(
        ActionChip(
          label: Text(ss[i]),
          avatar: Icon(Icons.check),
          backgroundColor: Colors.cyan,
          onPressed: (){print(ss[i]);},
        )
      );
    }


    UserLogin userLogin = Provider.of<UserLogin>(context);
    if(userLogin.getIsLogin())
    {
      print('no login');
    }
    else{

    }

    //introduceController.text ="sgg";
    return Scaffold(

      body: ListView(
        children: [
          userInfoSection(context,userLogin),
          const Divider(
            color: Colors.black38,
            height: 30,
            thickness: 2,
            indent: 200,
            endIndent: 200,
          ),
          
          // Container(
          //   margin: EdgeInsets.fromLTRB(400, 100, 400, 100),
          //   child: SingleChildScrollView(
          //     child: buildFake(context,temp),
          //   ),
          // )
          
        ],
      )


    );

  }


  Widget userInfoSection(BuildContext context, UserLogin userLogin) {
    return Container(
      margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
      color: Colors.grey[100],
      padding: EdgeInsets.fromLTRB(200, 50, 200, 30),
      
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //프로필사진, 아이디, 간단 소개
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(  //NetworkImage('https://picsum.photos/250?image=9')
                      // backgroundImage: temp.isProfile == false ? Image.asset('../assets/none.png').image : Image.asset('../assets/lee.png').image,
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                  // Container(
                  //   width: 200,
                  //   child: Wrap(
                  //     children: ac,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: RaisedButton(
                      child: Text("글쓰기"),
                      onPressed: (){
                        showEditPostDialog(context);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text("편집"),
                      onPressed: (){
                        showSettingDialog(context);
                      },
                    ),
                  )
                  
                  

                ],
              ),
              
              Padding(padding: EdgeInsets.all(30),),
              Container(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: <Widget>[           
                    Container(
                      // color: Colors.pink,
                      child: Text(
                        userLogin.getMe().nickname == null ? "":userLogin.getMe().nickname,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      //color: Colors.pink,
                      child: Text(
                        'temp'
                        // userLogin.getMe().infoText ==null ?"" : userLogin.getMe().infoText,
                        // temp.isIntro == false ? "" : "안녕하세요"
                      ),
                    )                           
                  ],
                ),
              )
              
            ],
          ),
        
          Padding(padding: EdgeInsets.all(30),),

          //팔로우, 팔로워
          
          
          
        ],
      ),
    );
  }

  Widget userInterestSection = Container(
    margin: EdgeInsets.all(300),
    child : Column(
      children: <Widget>[
        //NavigationBar()
        Card(
                margin: EdgeInsets.all(20),      
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('안녕하세요'),
                      subtitle: Text(
                        'flunge',
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.asset('../assets/blue.png',fit: BoxFit.fill,),
                    ),        
                  ],
                ),
              ),
      ],
    )

    // child: Row(
    //   children: [
    //     Padding(padding: EdgeInsets.all(30),),
    //     Column(
    //       children: <Widget>[
    //         Text(
    //           'fafafafafaf',
    //           style: TextStyle(fontSize: 40),
    //         ),
    //         Text(
    //           'fafafafafaf',
    //           style: TextStyle(fontSize: 40),
    //         ),
    //         Text(
    //           'fafafafafaf\n\n\n\n\n\n\n\n\n\n\naffaf',
    //           style: TextStyle(fontSize: 40),
    //         ),
    //       ],
    //     )
        
    //   ],
    // ),
  );



  Future<void> showEditPostDialog(BuildContext context){
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
          content: Container(
            width: MediaQuery.of(context).size.width*0.6,
            child: EditPage(),
          )
        );
      }

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
                SettingPage()
              ],
            ),
          ),
          )
        );
      }

    );
  }



}


// Row(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Text('팔로우',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text('0', 
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                       Padding(padding: EdgeInsets.all(20),),
//                       Column(
//                         children: <Widget>[
//                           Text('팔로워',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text('0', 
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       )
//                     ],
//                   ),



