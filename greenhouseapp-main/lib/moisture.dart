/*import 'package:flutter/material.dart';

int moist=0;
void setm(int a) {
  moist = a;
}

class Moisture extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [Text("Moisture"),Text('${moist}')]),
    );
  }
}*/
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import './notifi_service.dart';

BluetoothConnection connection;

ChartSeriesController _chartSeriesController;
List<LiveData> chartData = <LiveData>[
  LiveData(1, 0),
  LiveData(2, 0),
  LiveData(3, 0),
  LiveData(4, 0),
  LiveData(5, 0)
];
void Water() async {
  String text = 'water';
  if (text.isNotEmpty) {
    try {
      connection.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
      await connection.output.allSent;
      print("Watered");
    } finally {
      print("Not Watered");
    }
  }
}

class LiveData {
  final int time;
  final int moist;
  LiveData(this.time, this.moist);
}

List<LiveData> _addDataPoint(int z) {
  final int length = chartData.length;
  chartData.add(LiveData(x++, z));
  return chartData;
}

int moist = 0, x = 6, thmo = 550;
void setm(int a, BluetoothConnection connection1) async {
  moist = a;
  chartData = _addDataPoint(moist);
  connection = connection1;
  //_chartSeriesController.updateDataSource(
  //  addedDataIndexes: <int>[chartData.length - 1],
  //);
  if (moist > thmo) {
    Water();
    NotificationService()
              .showNotification(title: 'Soil Moisture', body: 'Soil is dry');
  }
}

void setthm(int z) {
  thmo = z;
  print("Gas:{$thmo}");
}

class Moisture extends StatefulWidget {
  @override
  State<Moisture> createState() => Moisture1();
}

class Moisture1 extends State<Moisture> {
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
              width: 140,
              height: 100,
            ),
            Text(
              " SOIL MOISTURE ",
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
          SizedBox(height: 5),
          ElevatedButton(
              onPressed: Water,
              child: Text(
                "   Click here to water the plants   ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    background: Paint()
                      ..color = Colors.blue
                      ..strokeWidth = 20
                      ..strokeJoin = StrokeJoin.round
                      ..strokeCap = StrokeCap.round
                      ..style = PaintingStyle.stroke,
                    color: Colors.black),
              )),
          SizedBox(height: 30),
          Text(
            " Value: $moist ",
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
                        yValueMapper: (LiveData sales, _) => sales.moist,
                        markerSettings: MarkerSettings(
                            isVisible: true, shape: DataMarkerType.diamond))
                  ])),
        ],
      ),
    );
  }
}
