import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/movie.dart';
import 'package:shop_ke/core/view_models/app_view_models/movies_view_model.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class MoviesGridTile extends StatelessWidget {
  final Movie movie;

  MoviesGridTile(this.movie);

  @override
  Widget build(BuildContext context) {
    return BaseView<MoviesViewModel>(
      builder: (context, model, child) => Card(
        child: Hero(
            tag: movie.movieId, //Make sure this is unique because duplicate tags will throw an error
            child: Material(
              child: InkWell(
                onTap: () {},
                child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: Text(
                        movie.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Genres ${movie.genres.toString()}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
//                    trailing: Text(
//                      "KES ${product.price}",
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.w800,
//                          decoration: TextDecoration.lineThrough),
//                    ),
                      trailing: FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline),
                        label: Text('More'),
                      ),
                    ),
                  ),
                  child: model.moviePosterFutureBuilder(movie.name),
                ),
              ),
            )),
      ),
    );
  }
}
