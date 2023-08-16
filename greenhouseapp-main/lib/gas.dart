import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import './notifi_service.dart';

List<LiveData> chartData = <LiveData>[
  LiveData(1, 0),
  LiveData(2, 0),
  LiveData(3, 0),
  LiveData(4, 0),
  LiveData(5, 0)
];

class LiveData {
  final int time;
  final int gas1;
  LiveData(this.time, this.gas1);
}

List<LiveData> _addDataPoint(int z) {
  final int length = chartData.length;
  chartData.add(LiveData(x++, z));
  return chartData;
}

int gas = 0, x = 6, thga = 350;
void setg(int a) {
  gas = a;
  chartData = _addDataPoint(gas);
  if (gas>thga)
  {
    NotificationService()
              .showNotification(title: 'Gas', body: 'Gas value crossed the threshold');
  }
}


void setthg(int z) {
  thga = z;
  print("Gas:{$thga}");
}

class Gas extends StatefulWidget {
  @override
  State<Gas> createState() => Gas1();
}

class Gas1 extends State<Gas> {
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 5000), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: [
            SizedBox(
              width: 150,
              height: 100,
            ),
            Text(
              " Carbon di-oxide ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  background: Paint()
                    ..color = Colors.purple
                    ..strokeWidth = 23
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: Colors.white),
            ),
          ]),
          SizedBox(height: 30),
          Text(
            " Value: $gas ",
            textAlign: TextAlign.center,
            style: TextStyle(
                background: Paint()
                  ..color = Colors.orange
                  ..strokeWidth = 20
                  ..strokeJoin = StrokeJoin.round
                  ..strokeCap = StrokeCap.round
                  ..style = PaintingStyle.stroke,
                color: Colors.white),
          ),
          SizedBox(height: 30),
          Container(
              height: 300,
              width: 300,
              //color: Colors.purple,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.yellow),
              child: SfCartesianChart(
                  primaryXAxis: NumericAxis(isVisible: false),
                  primaryYAxis: NumericAxis(
                      borderColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.black)),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<LiveData, int>(
                        dataSource: chartData,
                        xValueMapper: (LiveData sales, _) => sales.time,
                        yValueMapper: (LiveData sales, _) => sales.gas1,
                        markerSettings: MarkerSettings(
                            isVisible: true, shape: DataMarkerType.diamond))
                  ])),
        ],
      ),
    );
  }
}
