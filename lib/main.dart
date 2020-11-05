import 'package:flutter/material.dart';
import 'package:structure_flutter_mobile/pages/listuser/list_user_page.dart';

import 'di/injection.dart';

void main() async {
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'JobChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListUserPage(),
    );
  }
}
