import 'package:flutter/material.dart';
import 'app_view.dart';
import 'routes/router_generator.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PhotoFolioKR",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      builder: (_,child) => AppView(child: child),
      initialRoute: routeHome,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

