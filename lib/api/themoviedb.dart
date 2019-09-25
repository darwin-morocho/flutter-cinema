import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../constants.dart';
import '../serialize/movie.dart';

class TheMovieDb {
  final String apiKey;

  TheMovieDb(this.apiKey);

  Future<List<Movie>> nowPlaying(int page, {String lang = "es-EC"}) async {
    try {
      final url =
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=$lang&page=$page';

      print("url: $url");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final movies =
            (parsed['results'] as List).map((item) => Movie.fromJson(item));
        return movies.toList();
      }

      throw new PlatformException(code: "500", message: "Error feching $url");
    } on PlatformException catch (e) {
      printError(e);
      return [];
    }
  }

  Future<dynamic> incoming(int page, {String lang = "es-EC"}) async {
    try {
      final url =
          'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=$lang&page=$page&region=US';

      print("url: $url");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return parsed;
      }

      throw new PlatformException(code: "500", message: "Error feching $url");
    } on PlatformException catch (e) {
      printError(e);
      return null;
    }
  }

  Future<List<dynamic>> getTrailers() async {
    try {
      final url =
          'https://www.googleapis.com/youtube/v3/search?key=${Constants.youtubeApiKey}&channelId=${Constants.youtubeChannel}&part=snippet,id&order=date&maxResults=8';

      print("url: $url");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);

        return parsed['items'];
      }

      throw new PlatformException(code: "500", message: "Error feching $url");
    } on PlatformException catch (e) {
      printError(e);
      return [];
    }
  }

  printError(PlatformException e) {
    print("TheMovieDb error: ${e.message}");
  }
}
