import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_algostudio/components/home/home_view.dart';
import 'package:test_algostudio/utils/api.dart';
import 'package:test_algostudio/utils/app_data.dart';
import 'package:test_algostudio/utils/local_storage.dart';
import 'package:test_algostudio/widget/text_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AppData.clearAllData();
  LocalStorage.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'ALGO STUDIO',
        theme: ThemeData(
          fontFamily: 'InterRegular',
        ),
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
        // home: SlipGaji(),
        );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadingNextRoute();
    super.initState();
  }

  void loadingNextRoute() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(Home());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utility.baseColor2,
        body: Center(
          child:
              TextLabel(text: "Test Code Algo Studio", weigh: FontWeight.bold),
        ));
  }
}
