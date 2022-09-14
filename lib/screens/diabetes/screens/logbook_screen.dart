import 'package:flutter/material.dart';

import '../../../components/log_card.dart';
import '../../../services/glucose_log_service.dart';
import 'glucose_log_screen.dart';

class LogbookScreen extends StatefulWidget {
  LogbookScreen({Key? key, required this.period}) : super(key: key);
  String period = "This year";

  @override
  State<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.period);
    return Container(
      child: FutureBuilder(
        future: GlucoseLogService.getRecordsByTimeFrame("001", widget.period),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            int length = snapshot.data!.length;
            return ListView(
              shrinkWrap: true,
              children: List.generate(length, (index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GlucoseLogScreen(
                                  title: 'Edit Entry',
                                  logEntry: snapshot.data![index],
                                )),
                      ).then((_) => setState(() {}));
                    },
                    child: LogCard(
                      logEntry: snapshot.data![index],
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
