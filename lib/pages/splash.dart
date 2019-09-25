import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _myTask();
  }

  _myTask() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: FlareActor(
            "assets/flare/loading.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'loading',
          ),
        ),
      ),
    );
  }
}
