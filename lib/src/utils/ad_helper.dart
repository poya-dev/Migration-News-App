import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1739030504912973/5235241110";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1739030504912973/5235241110";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1739030504912973/3994311631";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1739030504912973/3994311631";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
