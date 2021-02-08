import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/core/view_models/app_view_models/movies_view_model.dart';
import 'package:shop_ke/ui/shared/app_bar/shopping_app_bar.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/movies_grid/movies_grid_view.dart';

class MoviesView extends StatefulWidget {
  static const routeName = '/movies';

  const MoviesView({Key key}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MoviesViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ShoppingAppBar(title: Text('Movie Shop')),
          drawer: AppDrawer(),
          body: FutureBuilder(
            future: model.getAllMovies(),
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
                    title: 'No Movies were found',
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
