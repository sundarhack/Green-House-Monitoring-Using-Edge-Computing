import 'package:flutter/material.dart';
import './notifi_service.dart';

import './homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenhouse Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Green house monitoring'),
    );
  }
}
