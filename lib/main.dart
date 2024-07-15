import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jele_apps/firebase_options.dart';
import 'package:jele_apps/service/messaging_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final messagingService = MessagingService();
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    initMessaging();
  }

  Future<void> initMessaging() async {
    await messagingService.init();
    setState(() {
      _fcmToken = messagingService.fcmToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _fcmToken == null
              ? CircularProgressIndicator()
              : Text(_fcmToken!),
        ),
      ),
    );
  }
}
