import 'package:shop_ke/core/enums/data_source.dart';

class Movie {
  String movieId;
  String name;
  List<String> genres;
  String year;

  Movie.fromMap(Map<String, dynamic> map, DataSource dataSource) {
    movieId = map['Movie_Id'];
    name = _getName(map['Name'], dataSource);
    genres = _getGenres(map['Genres'], dataSource);
  }

  String _getName(String name, DataSource dataSource) {
    switch (dataSource) {
      case DataSource.Database:
        name = _removeYearFromMovieTitle(name);
        break;
      case DataSource.Model: //remains unchanged
        break;

      default:
        throw new Exception('[getName] Data source not specified');
    }

    return name;
  }

  List<String> _getGenres(String genreString, DataSource dataSource) {
    List<String> genreList = [];
    switch (dataSource) {
      case DataSource.Database:
        genreList = _getGenresFromDatabase(genreString);
        break;
      case DataSource.Model: //remains unchanged
        break;
      default:
        throw new Exception('[getGenres] Data source not specified');
        break;
    }
    return genreList;
  }

  List<String> _getGenresFromDatabase(String genres) {
    final genreList = genres.split('|');
    return genreList;
  }

  String _removeYearFromMovieTitle(movieTitle) {
    var splitTitle = movieTitle.split('(');
//    year = splitTitle[1].replaceAll(')', '');
    String name = splitTitle[0].trim(); //Get rid of preceding and trailing whitespaces
    return name;
  }
}
