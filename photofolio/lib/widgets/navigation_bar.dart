
import 'package:flutter/material.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import '../pages/login_page.dart';
import '../routes/routes.dart';
import 'navigation_item.dart';

class NavigationBar extends StatefulWidget{

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar>{

  int index =0;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height : 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
            child:Text('dfgsf'),
            color: Colors.greenAccent,
            
            onPressed: (){
              
              showLoginDialog(navKey.currentContext);
            },
          )
        ],
        
      )
    );
    
  }

  Future<void> showLoginDialog(BuildContext context){
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
                      onPressed: () {
                        Navigator.of(context).pop();
                        
                      },
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



}








