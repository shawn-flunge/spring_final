
import 'package:flutter/material.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart';
import '../routes/routes.dart';
import 'navigation_item.dart';

class NavigationBar extends StatefulWidget{

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar>{

  int index =0;
  String login;
  List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin = Provider.of<UserLogin>(context);
    if(userLogin.getIsLoin()==false){
      login = "Login";
      setWidgets(userLogin);
    }
    else{
      login = userLogin.getEmail();
      setWidgets(userLogin);
    }
      



    

    return Container(
      height : 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets,
        // children: [
        //   Expanded(
        //     flex: 1,
        //     child: Container(
        //       margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        //       child: Text("logo"),
        //     )
        //   ),
        //   NavigationItem(
        //     title: "home",
        //     routeName : routeHome,
        //     selected:index==0,
        //     onHighlight:onHighlight,
        //   ),
        //   NavigationItem(
        //     title: "About",
        //     routeName: routeAbout,
        //     selected:index==1,
        //     onHighlight:onHighlight,
        //   ),
        //   RaisedButton(
        //     child:Text(login + userLogin.getIsLoin().toString()),
        //     padding : const EdgeInsets.symmetric(horizontal: 40),
        //     color: Colors.greenAccent,     
        //     onPressed: (){
        //       showLoginDialog(navKey.currentContext,userLogin);
        //     },
        //   ),
        // ],
        
      )
    );
    
  }

  Future<void> showLoginDialog(BuildContext context, UserLogin userLogin){
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.blue.withAlpha(70),
      transitionDuration: new Duration(milliseconds: 400),
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        return AlertDialog(
          elevation: 10,
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
                      onPressed: () =>Navigator.of(context).pop(),
                  ), 
                  alignment: FractionalOffset(1, 0),
                ),
                LoginPage(userLogin)
              ],
            ),
          ),
          )
        );
      }

    );
  }


  onHighlight(String route){
    switch (route){
      case routeHome :
        changeHighlight(0);
        break;
      case routeAbout :
        changeHighlight(1);
        break;
    }
  }

  changeHighlight(int newIndex){
    setState(() {
      index = newIndex;
    });
  }


  setWidgets(UserLogin userLogin){

    if(userLogin.getIsLoin() == false){
      widgets = <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:Text('PhotoFolioKR'),
            )
          ),
          NavigationItem(
            title: "home",
            routeName : routeHome,
            selected:index==0,
            onHighlight:onHighlight,
          ),
          RaisedButton(
            child:Text(login + userLogin.getIsLoin().toString()),
            padding : const EdgeInsets.symmetric(horizontal: 40),
            color: Colors.greenAccent,     
            onPressed: (){
              showLoginDialog(navKey.currentContext,userLogin);
            },
          ),

      ];

    }else{
      widgets = <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text("logo"),
            )
          ),
          NavigationItem(
            title: "home",
            routeName : routeHome,
            selected:index==0,
            onHighlight:onHighlight,
          ),
          NavigationItem(
            title: "About",
            routeName: routeAbout,
            selected:index==1,
            onHighlight:onHighlight,
          ),
          RaisedButton(
            child:Text(login + userLogin.getIsLoin().toString()),
            padding : const EdgeInsets.symmetric(horizontal: 40),
            color: Colors.greenAccent,     
            onPressed: (){
              showLoginDialog(navKey.currentContext,userLogin);
            },
          ),

      ];

    }

  }



}








