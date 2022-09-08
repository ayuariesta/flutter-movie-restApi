import 'package:flutter/material.dart';
import 'package:flutter_movie/service/http_service.dart';
import 'package:flutter_movie/pages/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int? moviesCount;
  late List movies;
  late HttpService service;

  String imgPath = 'https://image.tmdb.org/t/p/w500';

  Future initialize() async {
    movies = [];
    movies = (await service.getPopularMovies())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Popular Movies"),
        ),
        body: ListView.builder(
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          itemBuilder: (context, int position) {
            return Card(
              color: Colors.blue[50],
              elevation: 2.0,
              child: ListTile(
                leading: Image.network(imgPath + movies[position].posterPath),
                title: Text(movies[position].title),
                subtitle: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Rating = ' + movies[position].voteAverage.toString(),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          },
        ));
  }
}
