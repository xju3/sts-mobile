import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:duowoo/views/pages/account/splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // AppSettings.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Duowoo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: EasyLoading.init(),
        home: const SplashPage());
  }
}

void main() {
  runApp(const MyApp());
}
