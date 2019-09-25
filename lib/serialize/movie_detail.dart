class MovieDetail {
  final int id;
  final int vote_count;
  final int runtime;
  final bool video;
  final double vote_average;
  final String title;
  final double popularity;
  final String poster_path;
  final String original_language;
  final String original_title;
  final List<dynamic> genres;
  final String backdrop_path;
  final bool adult;
  final String overview;
  final String release_date;

  MovieDetail(
      {this.id,
        this.vote_count,
        this.runtime,
        this.video,
        this.vote_average,
        this.title,
        this.popularity,
        this.poster_path,
        this.original_language,
        this.original_title,
        this.genres,
        this.backdrop_path,
        this.adult,
        this.overview,
        this.release_date});

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      vote_count: json['vote_count'],
      video: json['video'],
      runtime: json['runtime'],
      vote_average: json['vote_average'].toDouble(),
      title: json['title'],
      popularity: json['popularity'],
      poster_path: json['poster_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      genres: json['genres'],
      backdrop_path: json['backdrop_path'],
      adult: json['adult'],
      overview: json['overview'],
      release_date: json['release_date'],
    );
  }
}
