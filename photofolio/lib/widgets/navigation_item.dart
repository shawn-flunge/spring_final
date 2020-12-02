import 'package:photofolio/widgets/interactive_nav_item.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:flutter/cupertino.dart';


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
    return GestureDetector(
      onTap : () {
        navKey.currentState.pushNamed(routeName);
        onHighlight(routeName);
      },
      child: Padding(
        padding : const EdgeInsets.symmetric(horizontal: 50),
        child: InteractiveNavItem(
          text: title,
          routeName:routeName,
          selected : selected,
        )
      )
    );
  }

}