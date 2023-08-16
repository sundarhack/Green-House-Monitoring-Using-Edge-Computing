import 'package:flutter/material.dart';
import 'dart:async';
import './humidity.dart';
import './temp.dart';
import './gas.dart';
import './moisture.dart';

int temp0=30, hum0=88, moi0=550, gas0=350;
void set() {
  setthh(hum0);
  settht(temp0);
  setthg(gas0);
  setthm(moi0);
}

String date = '';
String time = '';

void date1() {
  var da = DateTime.now();
  date = "" +
      da.day.toString() +
      "/" +
      da.month.toString() +
      "/" +
      da.year.toString();
  time = "" + da.hour.toString() + ":" + da.minute.toString();
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => Home1();
}

class Home1 extends State<Home> {
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 5000), (_) {
      setState(() {});
      date1();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Row(children: [
        SizedBox(
          width: 180,
          height: 65,
        ),
        Text(
          " Home ",
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
      SizedBox(height: 20),
      Row(
        children: [
          SizedBox(
            width: 50,
          ),
          Text(
            " Date: $date ",
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
          SizedBox(
            width: 80,
          ),
          Text(
            " TIme: $time ",
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
        ],
      ),
      
      SizedBox(height: 20),
      Image.asset('assets/greenhouse.png',height: 180,width: 180,),
      SizedBox(height: 15,),
     // Row(children: [ElevatedButton(onPressed: null, child: Text("Temperature")),TextField(label)],),
      Row(children: [ SizedBox(width: 30),ElevatedButton(onPressed: null, child: Text("Temperature")),SizedBox(width: 130,),SizedBox(width: 90,child: TextField( onChanged: (tempm) {
                    temp0 = int.parse(tempm);
                  },),)],),
      Row(children: [ SizedBox(width: 30),ElevatedButton(onPressed: null, child: Text("Humidty")),SizedBox(width: 150,),SizedBox(width: 90,child: TextField( onChanged: (humm) {
                    hum0 = int.parse(humm);
                  },),)],),
      Row(children: [ SizedBox(width: 30),ElevatedButton(onPressed: null, child: Text("Gas")),SizedBox(width: 170,),SizedBox(width: 90,child: TextField( onChanged: (gasm) {
                    gas0 = int.parse(gasm);
                  },),)],),
      Row(children: [ SizedBox(width: 30),ElevatedButton(onPressed: null, child: Text("Soil Moisture")),SizedBox(width: 100,),SizedBox(width: 100,child: TextField( onChanged: (moim) {
                    moi0 = int.parse(moim);
                  },),)],),
                  SizedBox(height: 15,),
      ElevatedButton(onPressed: set, child: Text("Set values")),
    ]
    )
    );
  }
}
