import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/firebase_options.dart';
import 'package:diabeta_app/model/ReceivedNotification.dart';
import 'package:diabeta_app/screens/login_screen.dart';
import 'package:diabeta_app/screens/main_screen.dart';
import 'package:diabeta_app/screens/reminders/reminder_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// The [SharedPreferences] key to access the alarm fire count.
const String countKey = 'count';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

/// Global [SharedPreferences] object.
// SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs!.containsKey(countKey)) {
    await prefs!.setInt(countKey, 0);
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: const LoginScreen(),
    );
  }
}

