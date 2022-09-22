import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/components/log_card.dart';
import 'package:diabeta_app/components/menu_card.dart';
import 'package:diabeta_app/model/log_count.dart';
import 'package:diabeta_app/screens/diabetes/screens/glucose_log_screen.dart';
import 'package:diabeta_app/screens/reports/report_screen.dart';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late ChartSeriesController _chartSeriesController;
  List<SplineAreaWeightData> _chartData = <SplineAreaWeightData>[];

  void getChartData() async {
    List<SplineAreaWeightData> _data = <SplineAreaWeightData>[];
    List data = await GlucoseLogService.getLast10GlucoseRecords('001');
    data.forEach((element) {
      _data.add(SplineAreaWeightData(
          DateFormat('MMM d').format(element.dateTime).toString(),
          element.glucoseLevel));
    });
    entryCountList = await GlucoseLogService.getRecordsCountByTimeFrame('001');
    setState(() {
      _chartData = _data;
    });
  }

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
    getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
          // Center(
          //   child: Container(
          //     color: Colors.teal[100],
          //     height: 200,
          //     child: SfCartesianChart(
          //       primaryXAxis: CategoryAxis(),
          //       series: <LineSeries<GlucoseData, String>>[
          //         LineSeries<GlucoseData, String>(
          //             dataSource: glucoseData,
          //             dataLabelSettings: const DataLabelSettings(
          //                 isVisible: true,
          //                 textStyle: TextStyle(color: kSecondaryColor)),
          //             xValueMapper: (GlucoseData sales, _) => sales.date,
          //             yValueMapper: (GlucoseData sales, _) => sales.sales),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChartCard(width, "Blood Glucose", _chartData),
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
              pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.grey, activeColor: Colors.white)),
              itemBuilder: (BuildContext context, int index) {
                return entryCountList.length > index
                    ? MenuCard(
                        logCount: entryCountList.elementAt(index),
                      )
                    : Container();
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

  Container ChartCard(
      double width, String title, List<SplineAreaWeightData> chartData) {
    return Container(
      height: 250,
      width: width - 20,
      margin: const EdgeInsets.only(top: 20.0),

      // width: size.width * 0.85,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            kPrimaryColor,
            // Color.fromARGB(255, 96, 207, 92),
            Color.fromARGB(255, 19, 170, 11),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // color: Colors.red[800],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Glucose Level',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: _chartData.isEmpty
                  ? Center(child: CircularProgressIndicator(color: Colors.white,))
                  : SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                      ),
                      enableAxisAnimation: true,
                      legend: Legend(isVisible: false, opacity: 0.7),
                      // title: ChartTitle(text: 'Inflation rate'),

                      plotAreaBorderWidth: 0,
                      primaryXAxis: CategoryAxis(
                          axisLine: AxisLine(
                            color: Colors.white,
                            width: 2,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          isVisible: true,
                          // maximumLabels: 5,
                          // interval: 1,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                      primaryYAxis: NumericAxis(
                          axisLine: AxisLine(
                            color: Colors.white,
                            width: 2,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          isVisible: true,
                          labelFormat: '{value}',
                          // axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0)),
                      series: <ChartSeries>[
                        SplineAreaSeries<SplineAreaWeightData, String>(
                          // animationDuration: 100,
                          markerSettings: MarkerSettings(
                              isVisible: true,
                              borderColor: Colors.white,
                              height: 4,
                              width: 4),
                          // gradient: LinearGradient(
                          //   colors: <Color>[
                          //     Colors.white.withAlpha(100),
                          //     Colors.white.withAlpha(10),
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;

                            // setState(() {
                            //   _chartSeriesController = controller;
                            // });
                          },
                          enableTooltip: true,
                          dataSource: _chartData,
                          borderColor: Colors.white,
                          splineType: SplineType.natural,
                          color: Colors.transparent,
                          borderWidth: 3,
                          name: 'mg/dL',
                          xValueMapper: (SplineAreaWeightData data, _) =>
                              data.title,
                          yValueMapper: (SplineAreaWeightData data, _) =>
                              data.value,
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlucoseData {
  GlucoseData(this.date, this.sales);
  final String date;
  final double sales;
}
