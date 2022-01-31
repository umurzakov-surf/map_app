import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:map_app/ui/map_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(const MapApp());
}
