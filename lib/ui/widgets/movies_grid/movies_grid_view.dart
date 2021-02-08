import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/ui/widgets/movies_grid/movies_grid_tile.dart';

class MoviesGridView extends StatelessWidget {
  final List<Movie> movies;

  MoviesGridView(this.movies, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (BuildContext context, int index) {
        Movie movie = movies[index];
        return MoviesGridTile(movie);
      },
    );
  }
}
