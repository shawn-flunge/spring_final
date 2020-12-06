
import 'package:flutter/material.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/login_page.dart';
import 'package:photofolio/pages/signup_page.dart';

import 'package:rflutter_alert/rflutter_alert.dart';


class HomePage extends StatelessWidget {


  List<Text> tt = List<Text>();


  @override
  Widget build(BuildContext context) {

    for(int i=0;i<10;i++){
      tt.add(
        Text(i.toString())
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Home Page',
            style: TextStyle(fontSize: 30),
          ),
          
            RaisedButton(
              child: Text('asdsad'),
              onPressed: () { sss(context);}
            ),
            
            RaisedButton(
              child: Text('show login'),
              onPressed: () { showLoginDialog(context);}
            ),
            RaisedButton(
              child: Text('show post'),
              onPressed: () { showPostDialog(context);}
            ),
            RaisedButton(
              child: Text('settings'),
              onPressed: () { 
                showSettingsDialog(context);
              }
            ),

            RaisedButton(
              child: Text('editing page'),
              onPressed: () { 
                Navigator.of(context).push(MaterialPageRoute(builder: (context) { return SignUpPage();}));
              }
            ),
            // Container(
            //   margin: EdgeInsets.all(100),
            //   padding: EdgeInsets.all(10),
            //   color: Colors.pink[300],
            //   width: double.infinity,
            //   height: 300,
            //   child: Center(
            //     child: GridView.count(
            //       shrinkWrap: true,
            //       crossAxisCount: 3,
            //       children: tt
            //     ),
            //   )
            // )
            Container(
              margin: EdgeInsets.all(100),
              padding: EdgeInsets.all(10),
              color: Colors.pink[300],
              width: double.infinity,
              height: 500,
              child: Center(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List<Widget>.generate(20, (index) {
                    return buildCard();
                  })
                ),
              )
            )
        ],
      )
    );
  }

  Widget buildCard(){

    // return Padding(
    //   padding: EdgeInsets.all(200),
    //   child: Container(
    //     color: Colors.purple[200],
    //     child: Text('gagsgd'),
    //   ),
    // );
    return Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(100),
      color: Colors.teal,
      child: Text('gagsgd'),
    );


  }



  Image img = Image.network('https://picsum.photos/250?image=9');

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      
      builder: (context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
                img
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> showPostDialog(BuildContext context){
  //   return showGeneralDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.pink[500].withAlpha(30),
  //     barrierLabel: "ff" ,
  //     transitionDuration: new Duration(seconds: 1),
      
  //     pageBuilder: (BuildContext con, Animation ani, Animation secAni){
  //       return Center(
  //         child: Container(
  //           width: MediaQuery.of(context).size.width*0.8,
  //           height: MediaQuery.of(context).size.height*0.7,
  //           color: Colors.lightBlue,
  //           child: RaisedButton(
  //             child : Text('close'),
              
  //             onPressed: (){
  //               Navigator.of(context).pop(context);
  //             },
  //           ),
  //         ),
  //       );
  //     }

  //   );
  // }

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
          content: Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: EditPage(),
          )
        );
      }

    );
  }
  

Future<void> showLoginDialog(BuildContext context){
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
                LoginPage()
              ],
            ),
          ),
          )
        );
      }

    );
  }

  Future<void> sss(BuildContext context){
    showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Column(
            children: [
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

