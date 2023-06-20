import 'package:flutter/material.dart';
import 'package:reminder_app_rs2/pages/home_page.dart';
import 'package:reminder_app_rs2/services/local_storage.dart';
import 'package:reminder_app_rs2/services/notification_services.dart';

LocalStorage localStorage = LocalStorage();
LocalNotification localNotification = LocalNotification();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localStorage.initialize();
  await localNotification.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
