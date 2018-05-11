import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Animation stuff',
    home: new MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('MainApp'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Show explanation',
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.alarm),
        onPressed: _startAnimation,
      ),
      body: new LogoWidget(),
    );
  }

  _startAnimation() {
    _state.restartAnimation();
  }
}

_LogoWidgetState _state; // yuk!

class LogoWidget extends StatefulWidget {
  _LogoWidgetState createState() {
    _state = _LogoWidgetState();
    return _state;
  }
}

class _LogoWidgetState extends State<LogoWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  restartAnimation() {
    controller.value == 1.0 ? controller.reverse() : controller.forward();
  }

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
