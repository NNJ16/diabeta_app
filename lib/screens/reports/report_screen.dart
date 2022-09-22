import 'package:diabeta_app/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineAreaWeightData {
  // SplineAreaData(this.year, this.y1, this.y2);
  // final double year;
  // final double y1;
  // final double y2;
  SplineAreaWeightData(this.title, this.value);
  final String title;
  final double value;
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late ChartSeriesController _chartSeriesController;
  List<SplineAreaWeightData> _chartData = <SplineAreaWeightData>[
    SplineAreaWeightData("Jan 10", 45),
    SplineAreaWeightData("Feb 12", 80),
    SplineAreaWeightData("Mar 12", 60),
    SplineAreaWeightData("Apr 12", 40),
    SplineAreaWeightData("May 12", 85),
    SplineAreaWeightData("Jun 12", 62),
    SplineAreaWeightData("Jul 12", 42),
    SplineAreaWeightData("Aug 12", 12),
    SplineAreaWeightData("Sep 12", 45),
    SplineAreaWeightData("Oct 12", 75),
    SplineAreaWeightData("Nov 12", 53),
    SplineAreaWeightData("Dec 12", 46),
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ChartCard(width, "Blood Glucose", _chartData),
              ChartCard(width,  "Carbohydrates", _chartData),
              ChartCard(width,  "", _chartData),
            ],
          ),
        ),
      ),
    );
  }

  Container ChartCard(double width, String title,List<SplineAreaWeightData> chartData ) {
    return Container(
      height: 380,
      width: width - 20,
      margin: const EdgeInsets.only(top: 20.0),

      // width: size.width * 0.85,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            kPrimaryColor,
            Color.fromARGB(255, 22, 104, 199),
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
              height: 320,
              child: SfCartesianChart(
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
                    onRendererCreated: (ChartSeriesController controller) {
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
                    xValueMapper: (SplineAreaWeightData data, _) => data.title,
                    yValueMapper: (SplineAreaWeightData data, _) => data.value,
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
