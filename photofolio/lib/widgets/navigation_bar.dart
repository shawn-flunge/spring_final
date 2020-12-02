
import 'package:photofolio/routes/routes.dart';
import 'package:flutter/cupertino.dart';
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
        ],
      )
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



// class NavigationBar extends StatelessWidget{

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.0,
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           NavigationItem(
//             title: "home",
//             routeName : routeHome
//           ),
//           NavigationItem(
//             title: "About",
//             routeName: routeAbout
//           ),
//         ],
//       )
//     );
//   }
// }







