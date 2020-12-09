import 'dart:ui';
import 'package:flutter/material.dart';
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
  void initState() {
    
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

  }

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin = Provider.of<UserLogin>(context);
    if(!userLogin.getIsLogin())
    {
      print('no login');
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
          userInterestSection
        ],
      )


    );

  }


  Widget userInfoSection(BuildContext context, UserLogin userLogin) {
    return Container(
      margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
      color: Colors.pink,
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Wrap(
                      children: ac,
                    ),
                  ),
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
                      color: Colors.pink,
                      child: Text(
                        userLogin.getNickName(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      color: Colors.pink,
                      child: Text(
                        'gaggagag\nagsgs\n\ndfgdfgdvvvvvvvvvvvvvvvvvvvvf\n'
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
        card,
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


  static var card = 
    Card(
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('title'),
            subtitle: Text(
              'subTitle',
              style: TextStyle(color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('dummy text dummy text dummy text dummy text'),
          ),
          Image.network('https://picsum.photos/250?image=9')
        ],
      ),
    );


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



