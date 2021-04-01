import 'package:bell/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bell Seting',
      theme: ThemeData(
        // colorScheme: randomColorSchemeDark(),
        // colorScheme: randomColorScheme(),
        primarySwatch: Colors.pink,
      ),
      home: Home(title: 'Bell Seting'),
    );
  }
}
