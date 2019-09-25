import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../serialize/movie.dart';
import '../serialize/movie_detail.dart';
import '../constants.dart';

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;
  final MovieDetail movieDetail;
  final VoidCallback onBuy;

  const MovieDetailHeader(
      {Key key, @required this.movie, @required this.movieDetail,@required this.onBuy})
      : super(key: key);

  Widget _mainHeader(Size size) {


    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: ClipPath(
            clipper: ArcClipper(),
            child: CachedNetworkImage(
              imageUrl: "${Constants.imgPath}${movie.backdrop_path}",
              width: double.infinity,
              height: 350.0,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.srcOver,
              color: new Color.fromARGB(120, 20, 10, 40),
            ),
          ),
        ),
        Positioned(
          bottom: -7.0,
          right: 0.0,
          child: CupertinoButton(
            padding: EdgeInsets.all(0.0),
            pressedOpacity: 0.3,
            onPressed: () {
//                      youtube.playYoutubeVideoById(
//                          apiKey: "AIzaSyBCfP7rIsyrywYhfuRJ4KUIDweeH7mbkSI",
//                          videoId: trailer,
//                          fullScreen: true //default false
//                      );
            },
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: TriClipper(),
                  child: Container(
                    width: size.width,
                    height: 290 / 2 + 15,
                    color: Colors.amber,
                  ),
                ),
                Positioned(
                  top: 290 / 8,
                  right: size.width / 12,
                  child: Center(
                      child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50.0,
                  )),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          right: 5.0,
          bottom: 10.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Material(
                borderRadius: BorderRadius.circular(4.0),
                elevation: 5.0,
                child: Hero(tag: movie.id,child: new CachedNetworkImage(
                  imageUrl:
                  "https://image.tmdb.org/t/p/w500/${movie.poster_path}",
                  width: 150.0,
                )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "IMDb",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Anton',
                          color: Colors.white),
                    ),
                    new Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          movie.vote_average.toString(),
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                        Text(
                          "/10",
                          style: TextStyle(
                              fontSize: 24.0, color: Color(0xFFd5d9d9d9)),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHead2() {
    var trailer = ""; //trailer de la pelicula
    var runtimeH = ""; //duracion de la pelicula
    var runtimeM = ""; //duracion de la pelicula
    var genres = ""; //generos de la pelicula

    //convertimos runtime a horas y minutos
    if (movieDetail.runtime != null) {
      runtimeH = "${(movieDetail.runtime / 60).floor()}";
      runtimeM = "${movieDetail.runtime % 60}";
    }
    var index = 0;
    for (var genre in movieDetail.genres) {
      genres +=
      "${genre['name']}${index < movieDetail.genres.length - 1 ? ',' : ''} ";
      index++;
    }
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: new Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  maxLines: 1,
                  softWrap: true,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${runtimeH}H",
                          style: TextStyle(
                              fontSize: 26.0,
                              color: Color(0xFFffa328),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${runtimeM}min",
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFFffa328),
                              height: 0.6),
                        )
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                        child: Text(
                      genres,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                      softWrap: true,
                      maxLines: 2,
                    ))
                  ],
                )
              ],
            ),
          )),
          SizedBox(
              width: 100,
              child: CupertinoButton(
                padding: EdgeInsets.all(0.0),
                pressedOpacity: 0.2,
                child: Image.asset(
                  'assets/images/buy_tickets.png',
                  width: 100.0,
                  fit: BoxFit.contain,
                ),
                onPressed: onBuy,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        _mainHeader(size),
        movieDetail!=null?_buildHead2():CupertinoActivityIndicator()
      ],
    );
  }
}

class TriClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(size.width / 2, size.height / 3);
    path.lineTo(size.width, size.height / 1.3);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height / 3);
    path.lineTo(size.width / 2, size.height / 3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 140.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
