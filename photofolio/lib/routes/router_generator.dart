import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/pages/post_page.dart';
import 'package:photofolio/routes/routes.dart';

import 'package:photofolio/pages/about_page.dart';
import 'package:photofolio/pages/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case routeHome : 
        return MaterialPageRoute(builder : (_) => HomePage());
        break;
      case routeAbout:
        return MaterialPageRoute(builder : (_) => AboutPage());
        break;
      case routePost:
        return MaterialPageRoute(builder : (_) => PostPage());
        break;
    }
  }
}