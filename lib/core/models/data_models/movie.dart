import 'package:shop_ke/core/enums/data_source.dart';

class Movie {
  String movieId;
  String name;
  List<String> genres;
  String year;
  String url;

  Movie.fromMap(Map<String, dynamic> map, DataSource dataSource) {
    movieId = map['Movie_Id'];
    name = map['Name'];
    genres = getGenres(map['Genres'], dataSource);
  }

  List<String> getGenres(String genreString, DataSource dataSource) {
    List<String> genreList = [];
    switch (dataSource) {
      case DataSource.Database:
        genreList = _getGenresFromDatabase(genreString);
        break;
      case DataSource.Model:
        genreList = _getGenresFromModel(genreString);
        break;
      default:
        throw new Exception('[getGenres] Data source not specified');
        break;
    }
    return genreList;
  }

  List<String> _getGenresFromDatabase(String genres) {
    final genreList = genres.split('|');
    print(genreList);
    return genreList;
  }

  List<String> _getGenresFromModel(String genres) {
    genres = genres.replaceAll('[', '');
    genres = genres.replaceAll(']', '');
    final genreList = genres.split(',');
    print(genreList);
    return genreList;
  }

  void removeYearFromMovieTitle(movieTitle) {
    String bracket = '(';
    String splitTitle = movieTitle.split(bracket);
    year = splitTitle[1].replaceAll(')', '');
    name = splitTitle[0].trim(); //Get rid of preceding and trailing whitespaces
  }
}
