import 'package:aula2/domain/movie.dart';
import 'package:aula2/domain/service/movie_service.dart';
import 'package:aula2/pages/movie_page.dart';
import 'package:aula2/utils/nav.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> with AutomaticKeepAliveClientMixin<MoviesPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.black,
      child: _listBuilder(context),
    );
  }

  _listBuilder(context) {
    Future<List<Movie>> movies = MovieService.getMovies();

    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Movie> movies = snapshot.data;
        return _listView(context,movies);
      },
    );
  }

  _listView(context, List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, idx) {
        final itemMovie = movies[idx];

        return Container(
//          color: Colors.green,
          child: Card(
            color: Colors.grey[850],
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200,
//                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(itemMovie.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"),
                          fit: BoxFit.fill
                      )
                    ),
                  ),
                  Text(
                    itemMovie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    itemMovie.vote_average.toString(),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          color: Colors.greenAccent[400],
                          textColor: Colors.white,
                          onPressed: () => _onClickMovie(context, itemMovie)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

//        return GestureDetector(
//          onTap: () => _onClickMovie(context, itemMovie),
//          child: Container(
//            padding: EdgeInsets.only(top: 20, bottom: 20),
//            child: ListTile(
//              leading: Image.network(
//                itemMovie.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
//                height: 80,
//              ),
//              title: Text(
//                "> ${itemMovie.title}",
//                style: TextStyle(
//                  fontSize: 20,
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold,
//                  fontStyle: FontStyle.italic,
//                  decoration: TextDecoration.underline,
//                ),
//              ),
//            ),
//          ),
//        );
      },
    );
  }

  _onClickMovie(BuildContext context, Movie itemMovie) {
    push(context, MoviePage(itemMovie));
  }

}