import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/core/view_models/app_view_models/movies_view_model.dart';
import 'package:shop_ke/ui/shared/app_bar/shopping_app_bar.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/movies_grid/movies_grid_view.dart';

class RecommendedMoviesView extends StatefulWidget {
  static const routeName = '/recommended-movies';
  final String movieTitle;

  const RecommendedMoviesView({Key key, @required this.movieTitle}) : super(key: key);

  @override
  _RecommendedMoviesViewState createState() => _RecommendedMoviesViewState();
}

class _RecommendedMoviesViewState extends State<RecommendedMoviesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MoviesViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ShoppingAppBar(title: Text('Related to ${widget.movieTitle}')),
          drawer: AppDrawer(),
          body: FutureBuilder(
            future: model.getMoviesLike(widget.movieTitle),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return LoadingView(
                  title: snapshot.error,
                  hasProgressIndicator: false,
                );
              } else if (snapshot.hasData) {
                List<Movie> movies = snapshot.data;
                if (movies.length > 0) {
                  return MoviesGridView(movies);
                } else {
                  return LoadingView(
                    title: 'No Movies like ${widget.movieTitle} were found',
                    hasProgressIndicator: false,
                  );
                }
              } else {
                return LoadingView();
              }
            },
          ),
        ),
      ),
    );
  }
}
