import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _gyroText = "";
  String _accelerometerText = "";

  AccelerometerEvent _accelerometerEvent;
  GyroscopeEvent _gyroscopeEvent;

  @override
  Widget build(BuildContext context) {

      accelerometerEvents.listen((AccelerometerEvent e) {
        setState(() {
          _accelerometerText = e.toString();
          _accelerometerEvent = e;
          print(_accelerometerText);
        });

      });

    gyroscopeEvents.listen((GyroscopeEvent e) {
      setState(() {
        _gyroText = e.toString();
        _gyroscopeEvent = e;
        print(_gyroText);
      });
    });

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(

        child: new Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '$_accelerometerText',
            ),
            new Text(
              '$_gyroText',
              style: Theme.of(context).textTheme.display1,
            ),
            new IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Firestore.instance.collection('users')
                  .document()
                  .collection('accelerometerEvent')
                  .document()
                  .setData({
                    'x': _accelerometerEvent.x,
                    'y': _accelerometerEvent.y,
                    'z': _accelerometerEvent.z
                  });

                  Firestore.instance.collection('users')
                      .document()
                      .collection('gyroscopeEvent')
                      .document()
                      .setData({
                    'x': _gyroscopeEvent.x,
                    'y': _gyroscopeEvent.y,
                    'z': _gyroscopeEvent.z
                  });
                }
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
