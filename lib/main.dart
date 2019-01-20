import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:scoped_model/scoped_model.dart';


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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
    _animation = new IntTween(begin: 0, end: 71).animate(_controller);
  }





  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_controller.isAnimating) {
                _controller.stop();
              } else {
                _controller.forward();
              }
              print("tapped");
            },
            child: new AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget child) {
                String frame = (_animation.value * 5).toString();
                return new Image.asset(
                  'assets/$frame.png',
                  gaplessPlayback: true,
                );
              },
            ),
          ),
          new Text('Image: Guillaume Kurkdjian', style: new TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  void checkStatus() {
    if (_animation.value == 5) {
      print("Good");
    }
  }


}


class StickModel extends Model {
  int index = 0;

  Future<void> animateImages() async {
    while(true) {
      Future.delayed(Duration(milliseconds: 100));

        if (index == 355) {
          index = 0;
        }
        index += 5;
        print("index is $index");
      notifyListeners();
    }

  }
  
}