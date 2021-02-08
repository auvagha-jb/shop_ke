import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/core/services/database_services/movies_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';

class MoviesViewModel extends BaseViewModel {
  final MoviesTable _moviesTable = new MoviesTable();

  Future<List<Movie>> getAllMovies() async {
    List<Movie> movies = [];
    movies = await _moviesTable.getTopMovies();
    return movies;
  }

  Future<String> getMoviePosterUrl(String movieTitle) async {
    String moviePosterUrl = await _moviesTable.getMoviePosterUrl(movieTitle);
    return moviePosterUrl;
  }

  FutureBuilder moviePosterFutureBuilder(String movieTitle) {
    return FutureBuilder(
      future: getMoviePosterUrl(movieTitle),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final dummyImageUrl = 'http://dummyimage.com/250x250.jpg/2e7d32/ffffff';
        final dummyImage = Image.network(
          dummyImageUrl,
          fit: BoxFit.cover,
        );

        if (snapshot.hasError) {
          print('snapshot.error for $movieTitle ${snapshot.error}');
          return dummyImage;
        } else if (snapshot.hasData) {
          String posterUrl = snapshot.data;
          return Image.network(
            posterUrl,
            fit: BoxFit.cover,
          );
        } else {
          return dummyImage;
        }
      },
    );
  }
}
