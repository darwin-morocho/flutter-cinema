class Movie {
  final int id;
  final int vote_count;
  final bool video;
  final double vote_average;
  final String title;
  final double popularity;
  final String poster_path;
  final String original_language;
  final String original_title;
  final List<dynamic> genre_ids;
  final String backdrop_path;
  final bool adult;
  final String overview;
  final String release_date;

  Movie(
      {this.id,
      this.vote_count,
      this.video,
      this.vote_average,
      this.title,
      this.popularity,
      this.poster_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.release_date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      vote_count: json['vote_count'],
      video: json['video'],
      vote_average: json['vote_average'].toDouble(),
      title: json['title'],
      popularity: json['popularity'],
      poster_path: json['poster_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      genre_ids: json['genre_ids'],
      backdrop_path: json['backdrop_path'],
      adult: json['adult'],
      overview: json['overview'],
      release_date: json['release_date'],
    );
  }
}
