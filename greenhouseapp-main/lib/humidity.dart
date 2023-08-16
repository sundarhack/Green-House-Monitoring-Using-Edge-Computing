import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import './notifi_service.dart';

ChartSeriesController _chartSeriesController;
List<LiveData> chartData = <LiveData>[
  LiveData(1, 0),
  LiveData(2, 0),
  LiveData(3, 0),
  LiveData(4, 0),
  LiveData(5, 0)
];

class LiveData {
  final int time;
  final int humid;
  LiveData(this.time, this.humid);
}

List<LiveData> _addDataPoint(int z) {
  final int length = chartData.length;
  chartData.add(LiveData(x++, z));
  return chartData;
}

int hum = 0, x = 6, thhum = 88;
void seth(int a) async {
  hum = a;
  chartData = await _addDataPoint(hum);
  //_chartSeriesController.updateDataSource(
  //  addedDataIndexes: <int>[chartData.length - 1],
  //);
  if (hum>thhum)
  {
    NotificationService()
              .showNotification(title: 'Humidity', body: 'Humidity crossed the threshold');
  }
}

void setthh(int z)
{
  thhum = z;
  print("Humidity:$thhum");
}

class Humidity extends StatefulWidget {
  @override
  State<Humidity> createState() => Humidity1();
}

class Humidity1 extends State<Humidity> {
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
              " HUMIDITY ",
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
            " Value: $hum ",
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
                        yValueMapper: (LiveData sales, _) => sales.humid,
                        markerSettings: MarkerSettings(
                            isVisible: true, shape: DataMarkerType.diamond))
                  ])),
        ],
      ),
    );
  }
}
