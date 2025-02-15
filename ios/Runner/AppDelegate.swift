import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  var blurEffectView: UIVisualEffectView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let screenProtectionChannel = FlutterMethodChannel(
        name: "com.protectionlayer",
        binaryMessenger: controller.binaryMessenger)

    screenProtectionChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "enableScreenProtection" {
        self.enableScreenProtection()
        result(nil)
      } else if call.method == "disableScreenProtection" {
        self.disableScreenProtection()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // Listen for app state changes
    NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func enableScreenProtection() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(screenRecordingDetected), name: UIScreen.capturedDidChangeNotification, object: nil)
  }

  private func disableScreenProtection() {
    NotificationCenter.default.removeObserver(self, name: UIScreen.capturedDidChangeNotification, object: nil)
    if let overlay = window?.viewWithTag(999) {
      overlay.removeFromSuperview()
    }
  }

  @objc private func screenRecordingDetected() {
    if UIScreen.main.isCaptured {
      let blackOverlay = UIView(frame: UIScreen.main.bounds)
      blackOverlay.backgroundColor = .black
      blackOverlay.tag = 999
      window?.addSubview(blackOverlay)
    } else {
      if let overlay = window?.viewWithTag(999) {
        overlay.removeFromSuperview()
      }
    }
  }

@objc private func appDidEnterBackground() {
    // Ensure the UI is fully rendered before adding the blur effect
    DispatchQueue.main.async {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView?.frame = self.window!.bounds
        self.blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.window?.addSubview(self.blurEffectView!)
    }
}

  @objc private func appWillEnterForeground() {
    // Remove the blur effect when the app enters the foreground
    blurEffectView?.removeFromSuperview()
  }
}
