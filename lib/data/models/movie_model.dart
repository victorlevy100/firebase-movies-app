class MovieModel {
  final int id;
  final String title;
  final String imagePath;
  final String overview;
  final DateTime releaseDate;
  final num voteAverage;
  final String? videoId;

  MovieModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    this.videoId,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      title: map['title'] as String,
      imagePath: map['poster_path'] as String,
      overview: map['overview'] as String,
      releaseDate: DateTime.parse(map['release_date'] as String),
      voteAverage: map['vote_average'] as num,
      videoId: map['videoKey'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'title': title,
      'poster_path': imagePath,
      'overview': overview,
      'release_date': releaseDate.toIso8601String(),
      'vote_average': voteAverage,
      'videoKey': videoId,
    };
  }


}