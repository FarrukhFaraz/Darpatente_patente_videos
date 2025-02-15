import 'dart:io';

import 'package:dar_formazione/util/http_config.dart';
import 'package:dar_formazione/util/protection_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FocusManager.instance.primaryFocus?.unfocus();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await ScreenProtection.enableScreenProtection();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DarFormazione',
      home: SplashScreen(),
    );
  }
}
