import 'dart:async';
import 'package:dar_formazione/util/colors.dart';
import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  String appVersion = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = 'V${packageInfo.version}';
    setState(() {});
  }

  Future<void> splash() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString("userToken");

    Timer(const Duration(milliseconds: 3000), () {
      if (userToken == null) {
        navReplace(context, const LoginScreen());
      } else {
        navReplace(context, const HomePageScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAppVersion();
    splash();

    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kcWhite,
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          appVersion,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: Image.asset(
              "assets/logo.png",
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
