
import 'package:flutter/material.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Home Page',
            style: TextStyle(fontSize: 30),
          ),
          RaisedButton(
              child: Text('Basic Alert'),
              onPressed: () => _onBasicAlertPressed(context),
            ),
            RaisedButton(
              child: Text('Custom Animation Alert'),
              onPressed: () => _onCustomAnimationAlertPressed(context),
            ),
            RaisedButton(
              child: Text('Alert with Button'),
              onPressed: () => _onAlertButtonPressed(context),
            ),
            RaisedButton(
              child: Text('Alert with Buttons'),
              onPressed: () => _onAlertButtonsPressed(context),
            ),
            RaisedButton(
              child: Text('Alert with Style'),
              onPressed: () => _onAlertWithStylePressed(context),
            ),
            RaisedButton(
              child: Text('Alert with Custom Image'),
              onPressed: () => _onAlertWithCustomImagePressed(context),
            ),
            RaisedButton(
              child: Text('Alert with Custom Content'),
              onPressed: () => _onAlertWithCustomContentPressed(context),
            ),
            RaisedButton(
              child: Text('vvvvvvvvvvvvvvvvvvvvvvvvvvvvv'),
              onPressed: () { _showMyDialog(context);}
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
              child: Text('editing page'),
              onPressed: () { 
                Navigator.of(context).push(MaterialPageRoute(builder: (context) { return EditPage();}));
              }
            ),
        ],
      )
    );
  }

  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
    ).show();
  }

//Custom animation alert
  _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: FadeAlertAnimation,
    ).show();
  }

  Widget FadeAlertAnimation(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

// Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _onCustomAnimationAlertPressed(context),
          width: 120,
        )
      ],
    ).show();
  }

// Alert with multiple and custom buttons
  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

// Advanced using of alerts
  _onAlertWithStylePressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.topCenter
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

// Alert custom images
  _onAlertWithCustomImagePressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      image: Image.asset("assets/success.png"),
    ).show();
  }

// Alert custom content
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
         title: Text('글쓰기'), 
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
      
      barrierColor: Colors.pink[500].withAlpha(30),
      transitionDuration: new Duration(milliseconds: 400),
      
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        return Center(
          child: Container(
            
            width: MediaQuery.of(context).size.width -500,
            height: MediaQuery.of(context).size.height -200,
            color: Colors.lightBlue,
            child: Column(

              children: [
                TextField(
                  
                ),
                TextField(
                  
                ),
                RaisedButton(
                  child: Text('login'),
                  onPressed: (){
                     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                    Navigator.of(context).pop();

                   
                  },
                )


              ],
            ) 
          ),
        );
      }

    );
  }
  



_zxv(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.none,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}

