import 'package:diabeta_app/model/ReceivedNotification.dart';
import 'package:diabeta_app/services/data_store.dart';
import 'package:diabeta_app/services/local_notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReminderDetails extends StatefulWidget {
  final String? activity;
  final String? dateTime;
  const ReminderDetails({Key? key, this.activity, this.dateTime})
      : super(key: key);

  @override
  _ReminderDetailsState createState() => _ReminderDetailsState();
}

class _ReminderDetailsState extends State<ReminderDetails> {
  late final LocalNotificationService service;
  DateTime pickedDate = DateTime.now();
  String notificationBody = '';

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    if (widget.activity != null && widget.dateTime != null) {
      notificationBody = widget.activity.toString();
      pickedDate = DateTime.parse(widget.dateTime.toString());
    }
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Reminder Details"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      pickedDate = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date And Time',
                  ),
                  controller: TextEditingController(
                      text: widget.dateTime != null
                          ? widget.dateTime.toString().substring(0, 10) +
                              "     " +
                              widget.dateTime.toString().substring(11, 16)
                          : pickedDate.toIso8601String().substring(0, 10) +
                              "     " +
                              pickedDate.toIso8601String().substring(11, 16)),
                  // onChanged: (value) {
                  //   setState(() {
                  //     print(value);
                  //     pickedDate = value;
                  //   });
                  // },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Activity',
                ),
                initialValue: widget.activity ?? '',
                // controller: TextEditingController(text: widget.activity ?? ''),
                onChanged: (value) {
                  setState(() {
                    print(value);
                    notificationBody = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await service.setScheduledNotification(
                      id: 0,
                      body: notificationBody ?? widget.activity ?? 'Not Found',
                      dateAndTime: pickedDate,
                    );
                    ReceivedNotification receivedNotification =
                        new ReceivedNotification(
                            id: 0,
                            title: "Diabeta Activity",
                            body: notificationBody,
                            payload: pickedDate.toString());
                    // await DataStore.shared.setReminderList(receivedNotification);
                    Navigator.pop(context, receivedNotification);
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Enter Valid Date"),
                      duration: Duration(milliseconds: 2000),
                    ));
                    // Fluttertoast.showToast(
                    //     msg: "Enter Valid Date",
                    //     backgroundColor: Color.fromARGB(255, 77, 77, 77),
                    //     textColor: Colors.white,
                    //     fontSize: 15.0);
                  }
                },
                child: const Text('Save Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
