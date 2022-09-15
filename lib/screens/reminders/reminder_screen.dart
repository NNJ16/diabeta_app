import 'dart:isolate';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:diabeta_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();

    // Register for events from the background isolate. These messages will
    // always coincide with an alarm firing.
    port.listen((_) async => await _incrementCounter());
  }

  Future<void> _incrementCounter() async {
    developer.log('Increment counter!');
    // Ensure we've loaded the updated count from the background isolate.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    setState(() {
      _counter++;
    });
  }

  // The background
  static SendPort? uiSendPort;

  // The callback for our alarm
  static Future<void> callback() async {
    developer.log('Alarm fired!');
    // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(countKey) ?? 0;
    await prefs.setInt(countKey, currentCount + 1);

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline4;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Alarm fired $_counter times',
              style: textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total alarms fired: ',
                  style: textStyle,
                ),
                Text(
                  // prefs.getInt(countKey).toString() ?? '',
                  "10",
                  key: const ValueKey('BackgroundCountText'),
                  style: textStyle,
                ),
              ],
            ),
            ElevatedButton(
              key: const ValueKey('RegisterOneShotAlarm'),
              onPressed: () async {
                await AndroidAlarmManager.oneShot(
                  const Duration(seconds: 5),
                  // Ensure we have a unique alarm ID.
                  Random().nextInt(pow(2, 31) as int),
                  callback,
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text(
                'Schedule OneShot Alarm',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
