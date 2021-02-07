import 'package:shop_ke/core/enums/data_source.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class MoviesTable extends ApiService {
  Future<List<Movie>> _getMovies(String endpoint, {DataSource dataSource = DataSource.Database}) async {
    final List<dynamic> moviesList = await super.getList(endpoint);
    List<Movie> movies = [];

    if (moviesList.length > 0) {
      for (var movie in moviesList) {
        movies.add(Movie.fromMap(movie, dataSource));
      }
    }
    return movies;
  }

  Future<List<Movie>> getTopMovies() async {
    final endpoint = route('movie/');
    final List<Movie> movies = await this._getMovies(endpoint);
    return movies;
  }

  Future<List<Movie>> getMoviePosters(String movieTitle) async {
    final endpoint = route('movie/genre/$movieTitle');
    final List<Movie> movies = await this._getMovies(endpoint);
    return movies;
  }

  Future<List<Movie>> getMovieRecommendations(String movieTitle) async {
    final endpoint = 'https://bioscope-api.herokuapp.com/movie?title=$movieTitle';
    final List<Movie> movies = await this._getMovies(endpoint, dataSource: DataSource.Model);
    return movies;
  }
}
