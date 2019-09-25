import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../api/themoviedb.dart';
import '../../constants.dart';

class IncomingTab extends StatefulWidget {
  @override
  _IncomingTabState createState() => _IncomingTabState();
}

class _IncomingTabState extends State<IncomingTab> {
  final ScrollController _scrollController = ScrollController();
  final _theMovieDB = TheMovieDb(Constants.apiKey);
  var _incomingMovies = List();
  var _page = 1;
  var _totalPages = -1;
  var _fetching = false;

  @override
  void initState() {
    super.initState();
    _getCatalog(1);
  }

  _getCatalog(int page) async {
    if ((_totalPages != -1 && page > _totalPages) || _fetching) return;

    setState(() {
      _fetching = true;
      _page = page;
    });

    final result = await _theMovieDB.incoming(page);
    if (result != null) {
      if (_totalPages == -1) {
        _totalPages = result['total_pages'];
      }
      final tmp = List();
      for (final item in result['results']) {
        if (item['poster_path'] != null) {
          tmp.add(item);
        }
      }

      setState(() {
        _incomingMovies.addAll(tmp);
      });
    }

    setState(() {
      _fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _incomingMovies.length > 0
        ? NotificationListener(
            onNotification: (t) {
              if (t is ScrollEndNotification) {
                if (_scrollController.offset >=
                        _scrollController.position.maxScrollExtent &&
                    !_scrollController.position.outOfRange) {
                  _getCatalog(_page + 1);
                }
              }
              return true;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: SafeArea(
                  bottom: false,
                  child: SizedBox(height: 60),
                )),
                SliverGrid.count(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    children: _incomingMovies.map((item) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            margin: EdgeInsets.all(3),
                            child: CupertinoButton(
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(0),
                                onPressed: () {},
                                child: Column(
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      imageUrl:
                                          "${Constants.imgPath}${item['poster_path']}",
                                      fit: BoxFit.cover,
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight - 30,
                                      placeholder: (context, placeholder) =>
                                          Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                    ),
                                    SizedBox(height: 3),
                                    Text(item['release_date'],
                                        style: TextStyle(fontSize: 13))
                                  ],
                                )),
                          );
                        },
                      );
                    }).toList())
              ],
            ),
          )
        : Center(
            child: CupertinoActivityIndicator(),
          );
  }
}
