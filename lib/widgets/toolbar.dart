import 'package:flutter/material.dart';

import '../constants.dart';

class Toolbar extends StatelessWidget {
  final String _title;
  final Widget leftView, rightView;

  const Toolbar(this._title,
      {Key key,
      this.leftView = const SizedBox(width: 50,),
      this.rightView = const SizedBox(width: 50,)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Constants.primaryColor.withOpacity(0.8),
              Constants.primaryColor.withOpacity(0.0),
            ])),
        child: SafeArea(
            child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            leftView,
            Expanded(
              child: Text(
                _title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Anton',
                    letterSpacing: 2),
              ),
            ),
           rightView,
            SizedBox(width: 10),
          ],
        )));
  }
}
