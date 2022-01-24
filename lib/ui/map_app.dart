import 'package:flutter/material.dart';

import 'home_page/home_page.dart';

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Map app',
      home: HomePage(),
    );
  }
}
