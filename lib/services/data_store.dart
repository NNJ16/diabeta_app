import 'dart:convert';

import 'package:diabeta_app/model/ReceivedNotification.dart';
import 'package:diabeta_app/screens/reminders/reminder_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  DataStore._privateConstructor();

  static final DataStore _instance = DataStore._privateConstructor();

  static DataStore get shared => _instance;

  static Future<SharedPreferences> _store = SharedPreferences.getInstance();

  // setInviteBranchId(String id) {
  //   _store.then((store) {
  //     store.setString("inviteBranchId", id);
  //   });
  // }

  // deleteInviteBranchId() {
  //   _store.then((store) {
  //     store.remove("inviteBranchId");
  //   });
  // }

  // Future<String> getInviteBranchId() async {
  //   final SharedPreferences store = await _store;
  //   final inviteBranchId = store.getString("inviteBranchId");
  //   return inviteBranchId;
  // }

  List<dynamic> _reminders = [];

  Future clearAll() async {
    final SharedPreferences store = await _store;
    _reminders = [];
    await store.clear();
  }

  Future<List<dynamic>> getReminderList() async {
    final SharedPreferences store = await _store;
    List<dynamic> _reminders = jsonDecode(store.getString("reminders") ?? '[]');
    print("_reminders");
    print(_reminders);
    return _reminders;
  }

  setReminderList(ReceivedNotification value) {
    _store.then((store) {
      _reminders = jsonDecode(store.getString("reminders") ?? '[]');
      _reminders.insert(0, {
        "id": value.id,
        "body": value.body,
        "payload": value.payload,
        "title": value.title,
      });
      String newReminders = jsonEncode(_reminders);
      print("newReminders");
      print(newReminders);
      store.setString("reminders", newReminders);
    });
  }

  setReminderFullList(List<dynamic> value) {
    _store.then((store) {
      String newReminders = jsonEncode(value);
      print("newReminders");
      print(newReminders);
      store.setString("reminders", newReminders);
    });
  }
}
