import 'package:flutter/material.dart';
import 'package:topcinema/serialize/movie.dart';

class Overview extends StatefulWidget {
  final Movie movie;

  const Overview(this.movie, {Key key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text(widget.movie.overview,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
