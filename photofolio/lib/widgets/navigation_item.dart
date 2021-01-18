import 'package:flutter/material.dart';
import 'package:photofolio/pages/login_page.dart';
import 'package:photofolio/widgets/interactive_nav_item.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:photofolio/provider/user_provider.dart';


class NavigationItem extends StatelessWidget{

  final String title;
  final String routeName;
  final bool selected;
  final Function onHighlight;
  

  const NavigationItem({
    @required this.title,
    @required this.routeName,
    @required this.selected,
    @required this.onHighlight,
    });

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isLoginOpend = false;
    
    if(MediaQuery.of(context).size.width>500){
      padding=EdgeInsets.symmetric(horizontal: 50);
    }else{
      padding=EdgeInsets.symmetric(horizontal: 10);
    }

    return GestureDetector(
      onTap : () {
        if(title == 'Login'){
          if(isLoginOpend == false){
            isLoginOpend = true;
            showLoginDialog(navKey.currentContext,userProvider).then((value) => isLoginOpend = false);
          }    
        }
        else{
          navKey.currentState.pushNamed(routeName);
          onHighlight(routeName);
        }       
      },
      child: Padding(
        padding : padding,
        child: InteractiveNavItem(
          text: title,
          routeName:routeName,
          selected : selected,
        )
      )
    );
  }

  Future<void> showLoginDialog(BuildContext context, UserProvider userProvider){
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.blue.withAlpha(70),
      barrierDismissible: true,
      barrierLabel: 'login dialog',
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
                LoginPage(userProvider)
              ],
            ),
          ),
          )
        );
      }

    );
  }


}