import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';

class TabBarButton extends StatefulWidget {
  final bool active;
  final String path;
  final int badgeCount;
  final VoidCallback onPressed;

  const TabBarButton(
      {Key key, this.path, this.badgeCount = 0, this.onPressed, this.active})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarButtonState();
}

class TabBarButtonState extends State<TabBarButton> {
  final _activeColors = [
    Constants.acentColor.withOpacity(0.6),
    Constants.acentColor.withOpacity(0.0),
  ];
  final _defaultColors = [
    Constants.primaryColor.withOpacity(0.8),
    Constants.primaryColor.withOpacity(0.8),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
              colors: widget.active ? _activeColors : _defaultColors)),
      child: FlatButton(
          padding: EdgeInsets.all(3),
          onPressed: widget.onPressed,
          highlightColor: Constants.acentColor.withOpacity(0.5),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              SafeArea(
                  top: false,
                  child: Container(
                    padding: EdgeInsets.all(9),
                    child: SvgPicture.asset(widget.path,
                        width: 30, height: 30, color: Colors.white),
                  )),
              widget.badgeCount > 0
                  ? Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 16,
                        height: 16,
                        child: Center(
                          child: Text(
                            widget.badgeCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8)),
                      ))
                  : SizedBox()
            ],
          )),
    ));
  }
}
