import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/components/log_card.dart';
import 'package:diabeta_app/components/menu_card.dart';
import 'package:diabeta_app/model/log_count.dart';
import 'package:diabeta_app/screens/diabetes/screens/glucose_log_screen.dart';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var glucoseData = <GlucoseData>[];
  var entryCountList = <LogCount>[];

  void initialaizeLineChart() async {
    List data = await GlucoseLogService.getLast10GlucoseRecords('001');
    var gdata = <GlucoseData>[];
    data.forEach((element) {
      gdata.add(GlucoseData(
          DateFormat('MMM d').format(element.dateTime).toString(),
          element.glucoseLevel));
    });
    entryCountList = await GlucoseLogService.getRecordsCountByTimeFrame('001');
    setState(() {
      glucoseData = gdata;
    });
  }

  @override
  void initState() {
    initialaizeLineChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: kSecondaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GlucoseLogScreen()),
            ).then((_) => setState(() {}));
          },
          child: const Icon(Icons.add)),
      body: ListView(
        children: [
          Center(
            child: Container(
              color: Colors.teal[100],
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<GlucoseData, String>>[
                  LineSeries<GlucoseData, String>(
                      dataSource: glucoseData,
                      dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(color: kSecondaryColor)),
                      xValueMapper: (GlucoseData sales, _) => sales.date,
                      yValueMapper: (GlucoseData sales, _) => sales.sales),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: Swiper(
              loop: false,
              itemCount: 3,
              itemHeight: 400.0,
              itemWidth: 600,
              duration: 1500,
              autoplayDelay: 8000,
              onIndexChanged: (index) {},
              layout: SwiperLayout.STACK,
              pagination: const SwiperPagination(),
              itemBuilder: (BuildContext context, int index) {
                return entryCountList.length > index ? MenuCard(logCount: entryCountList.elementAt(index),) : Container();
              },
            ),
          ),
          FutureBuilder(
            future: GlucoseLogService.getLast10Records('001'),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int length = snapshot.data!.length;
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    length,
                    (index) {
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
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class GlucoseData {
  GlucoseData(this.date, this.sales);
  final String date;
  final double sales;
}
