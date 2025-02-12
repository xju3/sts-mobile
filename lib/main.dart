import 'package:duowoo/views/pages/review/review.dart';
import 'package:flutter/material.dart';

import 'package:duowoo/views/pages/account/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    askForPositionPermission();
  }

  void askForPositionPermission() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var locationService = pref.get("location_service");
    if (locationService == null) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        try {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // Permissions are denied, next time you could try
            // requesting the permission again (this is also where
            // Android's shouldShowRequestPermissionRationale returned true.
            return Future.error(
                'Location permissions are denied, we cannot request permissions.');
          }
        } catch (e) {
          return Future.error(e);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
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
        routes: {
          '/review': (context) => ReviewPage(), // 配置/home路由对应的页面
        },
        home: const SplashPage());
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 强制竖屏
    DeviceOrientation.portraitDown, // 强制竖屏
  ]).then((_) {
    runApp(MyApp());
  });
}
