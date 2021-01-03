import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/provider/post_provider.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/navigation_bar.dart';

class AppView extends StatelessWidget {
  final Widget child;

  const AppView({@required this.child});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserLogin>(create:(context)=> UserLogin()),
        ChangeNotifierProvider<PostProvider>(create:(context)=>PostProvider())
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            NavigationBar(),
            Expanded(child: child,),
          ],
        ),
      ),
    );


    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Column(
    //     children: [
    //       NavigationBar(),
    //       Expanded(child: child,),
    //     ],
    //   ),
    // );
  }
}
