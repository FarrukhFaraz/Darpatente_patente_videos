import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

class ScreenProtection {
  ScreenProtection._();

  static enableScreenProtection() async {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        print('ScreenProtection.enableScreenProtection::::: Android protection layer');
      }

      await ScreenProtector.protectDataLeakageWithColor(Colors.white);
      await ScreenProtector.preventScreenshotOn();
    } else {
      if (kDebugMode) {
        print('ScreenProtection.enableScreenProtection::::: Ios protection layer');
      }

      await ScreenProtector.protectDataLeakageWithColor(Colors.white);
      await ScreenProtector.preventScreenshotOn();
    }
  }
}
