import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:topcinema/widgets/movie_detail_header.dart';
import 'package:topcinema/widgets/overview.dart';
import '../serialize/movie.dart';
import '../serialize/movie_detail.dart';
import '../constants.dart';
import '../widgets/toolbar.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieDetail _movie;
  List<Actor> _actors = List();

  final _funcionesKey = new GlobalKey();

  final List<Entrada> entradas = <Entrada>[
    new Entrada(1, '11H00', '2D', 'Español', true),
    new Entrada(2, '13H030', '2D', 'Español', true),
    new Entrada(3, '15H00', '3D', 'Subtitulado', false),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  /**
   * recupera los datos de la pelicula sgun el id
   */
  _init() async {
    var url =
        'https://api.themoviedb.org/3/movie/${widget.movie.id}?api_key=${Constants.apiKey}&language=es-EC';
    final response = await http.get(url);
    var parsed = jsonDecode(response.body);
    if (parsed['id'] != null) {
      var tmp = MovieDetail.fromJson(parsed);

      if (!mounted) return;
      setState(() {
        _movie = tmp;
      });
      _fetchCast();
    }
  }

  //metodo para leer las peliculas y convertirlas a un array de movies
  _fetchCast() async {
    try {
      var url =
          'https://api.themoviedb.org/3/movie/${widget.movie.id}/credits?api_key=${Constants.apiKey}';
      print("cast $url");

      final response = await http.get(url);
      var parsed = jsonDecode(response.body);

      final tmp = List<Actor>();

      for (final item in parsed['cast']) {
        final actor = Actor.fromJson(item);

        if (actor.profile_path != null) {
          tmp.add(actor);
        }
      }

      setState(() {
        _actors = tmp;
      });
    } catch (e) {
      print("Error cast ${e.toString()}");
    }
  }

  _funciones() {
    List<Widget> widgets = List<Widget>();
    widgets.add(_funcionColumns());
    for (var e in entradas) {
      widgets.add(_funcionRow(e));
    }
    return widgets;
  }

  Widget _funcionColumns() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "#",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Anton', color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Hora",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Anton',
                    letterSpacing: 2.0,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Calidad",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Anton',
                    letterSpacing: 2.0,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Idioma",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Anton',
                    letterSpacing: 2.0,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Tickets",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Anton',
                    letterSpacing: 2.0,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _funcionRow(Entrada entrada) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                entrada.num.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                entrada.hora,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                entrada.dimension,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Color(0xFF263238))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                entrada.idioma,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Container(
              decoration: new BoxDecoration(
                  border: new Border.all(color: Color(0xFF263238))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  entrada.disponible == true ? 'COMPRAR' : 'AGOTADO',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MovieDetailHeader(
                  movie: widget.movie,
                  movieDetail: _movie,
                  onBuy: () {
                    Scrollable.ensureVisible(_funcionesKey.currentContext,
                        duration: Duration(seconds: 1));
                  },
                ),
                Overview(widget.movie),
                SizedBox(
                  height: 135,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _actors.map((Actor actor) {
                      final imgUrl =
                          "${Constants.imgPath}${actor.profile_path}";

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: imgUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, string) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                        child: CupertinoActivityIndicator()),
                                  );
                                },
                              ),
                            ),
                            Text(
                              actor.character,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              actor.name,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    key: _funcionesKey,
                    width: size.width,
                    padding: EdgeInsets.only(top: 20, bottom: 5, left: 10),
                    child: Text(
                      "FUNCIONES",
                      style: TextStyle(
                          color: Constants.acentColor,
                          fontSize: 20,
                          fontFamily: 'Anton',
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _funciones(),
                ),
                SafeArea(child: SizedBox())
              ],
            ),
          ),
          Toolbar(
            "DINA.ec",
            leftView: CupertinoButton(
              padding: EdgeInsets.all(0),
              color: Color(0xfff0f0f0).withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Actor {
  final String name;
  final String character;
  final String profile_path;

  Actor({this.name, this.character, this.profile_path});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
        name: json['name'],
        profile_path: json['profile_path'],
        character: json['character']);
  }
}

class Entrada {
  final int num;
  final String hora, dimension, idioma;
  final bool disponible;

  Entrada(this.num, this.hora, this.dimension, this.idioma, this.disponible);

  @override
  DataRow getRow() {
    return new DataRow(cells: [
      new DataCell(Text(num.toString())),
      new DataCell(Text(hora)),
      new DataCell(Text(dimension)),
      new DataCell(Text(idioma)),
      new DataCell(Text(dimension == true ? 'COMPRAR' : 'AGOTADO')),
    ]);
  }
}
