import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:patente_videos/Screens/Utils/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/login_page.dart';
import '../Home_Screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String appVersion = '';

  getAppVersion()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = 'V${packageInfo.version}';
    print('app::::::::::$appVersion');
    setState(() {});
  }

  splash() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString("userToken");
    Timer(const Duration(milliseconds: 3400), (() {
      if (userToken == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const LoginPageScreen())));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const HomePageScreen())));
      }
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppVersion();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kLightGrey,
        bottomNavigationBar: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text('$appVersion' , style: TextStyle(fontSize: 16 , color: kBlack),),
        ),
        body: Center(
          child: Image.asset(
            "assets/images/Last logo.jpeg",
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
