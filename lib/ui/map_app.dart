import 'package:flutter/material.dart';

import 'home_page/home_page.dart';

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map app',
      home: const HomePage(),
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
