import 'dart:ui';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget{

  AboutPageState createState() => AboutPageState();
}



class AboutPageState extends State<AboutPage> {
  TextEditingController introduceController;

  

  @override
  Widget build(BuildContext context) {
    //introduceController.text ="sgg";
    return Scaffold(

      body: ListView(
        children: [
          userInfoSection(context),
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


  Widget userInfoSection(BuildContext context) {
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
                  

                ],
              ),
              
              Padding(padding: EdgeInsets.all(30),),
              Column(
                // mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: <Widget>[           
                  Container(
                    color: Colors.white,
                    child: Text(
                      'flunge',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Text(
                      'gaggagag\nagsgs\n\ndfgdfgdvvvvvvvvvvvvvvvvvvvvf\n'
                    ),
                  )
                  
            
                ],
              ),
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



