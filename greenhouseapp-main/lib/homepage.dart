import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/services.dart';
import './bluetooth.dart';
import './temp.dart';
import './home.dart';
import './gas.dart';
import './moisture.dart';
import 'humidity.dart';
import './profile.dart';
import 'package:http/http.dart' as http;

enum BluetoothConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  BluetoothConnectionState _btStatus = BluetoothConnectionState.disconnected;
  BluetoothConnection connection;
  String _messageBuffer = '';

  void _onDataReceived(Uint8List data) async {
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });

    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    print("Buffer:${buffer}");

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    var message = ' ';
    print("test1");
    if (~index != 0) {
      message = backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString.substring(0, index);
      _messageBuffer = dataString.substring(index);
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    print(message);
    if (message.isNotEmpty) {
      print("hello${message}");
      var arr = message.split("|");
      print(arr);

      sett(int.parse(arr[0]));
      seth(int.parse(arr[1]));
      setm(int.parse(arr[2]),connection);
      setg(int.parse(arr[3]));
      var url= "https://api.thingspeak.com/update?api_key=LX9Q3P3FAA4I1DK9&field1="+arr[0]+"&field2="+arr[1]+"&field3="+arr[3]+"&field4="+arr[2];
      final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        //backgroundColor: Colors.black87,
        actions: [
          IconButton(
              onPressed: () async {
                BluetoothDevice device = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => BluetoothDevices()));

                if (device == null) return;

                print('Connecting to device...');
                setState(() {
                  _btStatus = BluetoothConnectionState.connecting;
                });

                BluetoothConnection.toAddress(device.address)
                    .then((_connection) {
                  print('Connected to the device');
                  connection = _connection;
                  setState(() {
                    _btStatus = BluetoothConnectionState.connected;
                  });

                  connection.input.listen(_onDataReceived).onDone(() {
                    setState(() {
                      _btStatus = BluetoothConnectionState.disconnected;
                    });
                  });
                }).catchError((error) {
                  print('Cannot connect, exception occured');
                  print(error);

                  setState(() {
                    _btStatus = BluetoothConnectionState.error;
                  });
                });
              },
              icon: Icon(Icons.settings_bluetooth))
        ],
      ),
      extendBody: true,
      body: Center(
          child: Expanded(child: Column(
        children: [
          if (_index == 0) ...[
            Home(),
          ] else if (_index == 1) ...[
            Temp(),
          ] else if (_index == 2) ...[
            Gas(),
          ] else if (_index == 3) ...[
            Moisture(),
          ] else if (_index == 4) ...[
            Humidity(),
          ] else if (_index == 5) ...[
            Profile(),
          ],
        ],
      ))),
      bottomNavigationBar: FloatingNavbar(
          width: 270,
          unselectedItemColor: Colors.green,
          onTap: (int val) => setState(() => _index = val),
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home),
            FloatingNavbarItem(
              icon: Icons.device_thermostat_sharp,
            ),
            FloatingNavbarItem(icon: Icons.gas_meter),
            FloatingNavbarItem(icon: Icons.water_sharp),
            FloatingNavbarItem(icon: Icons.water_drop_sharp),
            FloatingNavbarItem(icon: Icons.person_pin_outlined)
          ],
          selectedItemColor: Colors.amber[800],
          ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenhouse',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Green House Monitoring'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
