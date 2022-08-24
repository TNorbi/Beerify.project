import 'package:beerify/core/route_constants.dart';
import 'package:beerify/core/app_router.dart';
import 'package:flutter/material.dart';
import 'package:beerify/server.dart' as server;

import 'dart:typed_data';

void main() async {
  await server.connect();
  //print("Megvolt a connect");
  //print("Elemek: ");
  //for (dynamic v in result) {
  //  print(v.toString());
  // }
  //print(result.length);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Beer app",
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.loginRoute,
    );
  }
}
