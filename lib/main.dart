import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';

import './src/services/fcm_service.dart';
import 'src/preferences/preferences.dart';
import './src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMService.initializeFirebase();
  await FCMService.initializeLocalNotification();
  await FCMService.onBackgroundMessage();
  await FCMService.onForegroundMessage();
  await FCMService.getDeviceToken();
  await Preferences.init();
  runApp(const MyApp());
}
