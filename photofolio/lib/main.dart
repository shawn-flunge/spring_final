import 'package:flutter/material.dart';
import 'app_view.dart';
import 'routes/router_generator.dart';
import 'routes/routes.dart';


Map<int, Color> color =
{
50:Color.fromRGBO(33 ,33, 33, .1),
100:Color.fromRGBO(33 ,33, 33, .2),
200:Color.fromRGBO(33 ,33, 33, .3),
300:Color.fromRGBO(33 ,33, 33, .4),
400:Color.fromRGBO(33 ,33, 33, .5),
500:Color.fromRGBO(33 ,33, 33, .6),
600:Color.fromRGBO(33 ,33, 33, .7),
700:Color.fromRGBO(33 ,33, 33, .8),
800:Color.fromRGBO(33 ,33, 33, .9),
900:Color.fromRGBO(33 ,33, 33, 1),
};


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PHOTOFOLIO",
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primarySwatch: MaterialColor(0xFF212121, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (_,child) => AppView(child: child),
      initialRoute: routeHome,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

