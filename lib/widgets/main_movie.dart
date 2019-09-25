import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../serialize/movie.dart';
import '../constants.dart';

class MainMovie extends StatelessWidget {
  final Movie movie;
  final double height;

  const MainMovie({Key key, @required this.movie, this.height = 400})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: "${Constants.imgPath}${movie.backdrop_path}",
              height: height,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.srcOver,
              color: new Color.fromRGBO(0, 0, 0, 0.3)),
          Positioned(
              bottom: -1,
              left: 0.0,
              right: 0.0,
              child: new Container(
                height: 180.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter, // new
                    end: Alignment.bottomCenter, // new

                    colors: [
                      Color.fromRGBO(28, 36, 41, 0.0),
                      Color.fromRGBO(28, 36, 41, 0.2),
                      Color.fromRGBO(28, 36, 41, 0.6),
                      Color.fromRGBO(28, 36, 41, 1.0),
                    ],
                  ),
                ),
              )),
          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 10.0,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                        flex: 5,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Material(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 5.0),
                                  child: Text(
                                    "ESTRENO",
                                    style: TextStyle(
                                        fontFamily: 'Anton',
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        letterSpacing: 2.0),
                                  )),
                              color: Colors.amber,
                            ),
                            SizedBox(height: 5.0),
                            new Text(
                              movie.title.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'Anton',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  letterSpacing: 2.0),
                            ),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "${movie.vote_count}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 20.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "${movie.vote_average} / 10",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            new Text(
                              movie.overview,
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  height: 0.8),
                            )
                          ],
                        )),
                    SizedBox(width: 10.0),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[],
                    )
                  ],
                ),
              )),
          new Positioned(
            top: height * 0.35,
            left: 0.0,
            right: 0.0,
            child: new Center(
              child: new CupertinoButton(
                pressedOpacity: 0.3,
                onPressed: () {},
                child: new Container(
                  padding: EdgeInsets.only(
                      left: 25.0, top: 20.0, bottom: 20.0, right: 20.0),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                  child: Icon(
                    Icons.play_arrow,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
