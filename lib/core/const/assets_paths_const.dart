class AssetsPathsConst {
  static final AssetsPathsConst _singleton = AssetsPathsConst._internal();

  factory AssetsPathsConst() {
    return _singleton;
  }

  AssetsPathsConst._internal();

  static const String _animationFolder = 'assets/animations';

  static String get splashAnimation => '$_animationFolder/34590-movie-theatre.json';
  static String get loginAnimation =>
      '$_animationFolder/26406-clapperboard.json';
  static String get animationPopcorn => '$_animationFolder/59537-popcorn.json';
  static const String _imageFolder = 'assets/images';
  static String get cinemaImage => '$_imageFolder/cinema.jpg';
}