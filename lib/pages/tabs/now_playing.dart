import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import '../../widgets/main_movie.dart';
import '../../serialize/movie.dart';
import '../../api/themoviedb.dart';
import '../../constants.dart';
import '../movie.dart';

class NowPlayingTab extends StatefulWidget {
  @override
  _NowPlayingTabState createState() => _NowPlayingTabState();
}

class _NowPlayingTabState extends State<NowPlayingTab> {
  final _theMovieDb = TheMovieDb(Constants.apiKey);

  var _movies = List<Movie>();
  var _trailers = List();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final movies = await _theMovieDb.nowPlaying(1);
    print("movies ${movies.length}");
    setState(() {
      _movies = movies;
    });
    final trailers = await _theMovieDb.getTrailers();
    setState(() {
      _trailers = trailers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: _movies.length > 0
          ? LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MainMovie(
                        movie: _movies[0],
                        height: size.height * 0.53,
                      ),
                      SizedBox(height: 10),
                      ButtonText(
                        "EN CARTELERA",
                        onPressed: () {},
                      ),
                      Container(
                          height: 190,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _movies
                                .map((Movie movie) => MovieItem(movie: movie))
                                .toList(),
                          )),
                      SizedBox(height: 10),
                      ButtonText(
                        "TRAILERS y MÁS",
                        onPressed: () {},
                      ),
                      Container(
                        height: 220,
                        child: PageView(
                          children: _trailers.map((item) {
                            return Stack(
                              children: <Widget>[
                                Positioned.fill(
                                    child: CachedNetworkImage(
                                        imageUrl: item['snippet']['thumbnails']
                                            ['high']['url'],
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.srcOver,
                                        color: new Color.fromRGBO(0, 0, 0, 0.3),
                                        placeholder: (context, string) {
                                          return Container(
                                            child: Center(
                                                child:
                                                    CupertinoActivityIndicator()),
                                          );
                                        })),
                                Positioned.fill(
                                  child: CupertinoButton(
                                      onPressed: () {
                                        _playYoutube(item['id']['videoId']);
                                      },
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        size: 70,
                                      )),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  _playYoutube(String id) {
    FlutterYoutube.playYoutubeVideoById(
        apiKey: Constants.youtubeApiKey,
        videoId: id,
        autoPlay: true, //default falase
        fullScreen: true //default false
        );
  }
}

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoButton(
        padding: EdgeInsets.all(4),
        child: Hero(
            tag: movie.id,
            child: CachedNetworkImage(
              imageUrl: "${Constants.imgPath}${movie.poster_path}",
              fit: BoxFit.cover,
              height: size.height,
              width: size.width / 3,
            )),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MoviePage(
                        movie: movie,
                      )));
        });
  }
}

class ButtonText extends StatelessWidget {
  final String _text;
  final VoidCallback onPressed;

  const ButtonText(this._text, {Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              _text,
              style: TextStyle(
                  fontFamily: 'Anton', letterSpacing: 2.0, color: Colors.white),
            )),
        new CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            minSize: 25,
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Text(
                  "TODO",
                  style: TextStyle(color: Constants.acentColor),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Constants.acentColor,
                )
              ],
            ))
      ],
    );
  }
}
