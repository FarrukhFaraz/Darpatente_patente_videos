import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScreenProtection {
  static const MethodChannel _platform = MethodChannel('com.protectionlayer');

  static Future<void> enableScreenProtection() async {
    if (Platform.isIOS) {
      if (kDebugMode) {
        print('ScreenProtection.enableScreenProtection:::::::is ios');
      }
      try {
        var data = await _platform.invokeMethod('enableScreenProtection');
        if (kDebugMode) {
          print('ScreenProtection.enableScreenProtection::::: $data');
        }
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print("Failed to enable screen protection: ${e.message}");
        }
      }
    } else {
      if (kDebugMode) {
        print('ScreenProtection.enableScreenProtection::::is android');
      }
    }
  }

  static Future<void> disableScreenProtection() async {
    if (kDebugMode) {
      print('ScreenProtection.disableScreenProtection');
    }
    try {
      await _platform.invokeMethod('disableScreenProtection');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to disable screen protection: ${e.message}");
      }
    }
  }
}
