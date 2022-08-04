import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_api_movies/movie_model.dart';
import 'package:get_api_movies/movie_repository.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MovieRepository repository = MovieRepository(Dio());
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    movies = repository.getAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studio Ghibli'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: movies,
        builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MovieModel movie = snapshot.data![index];
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(movie.movieBanner),
                                fit: BoxFit.cover,
                                opacity: 0.4),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      movie.originalTitle,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        const Text(
                                          'Director: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(movie.director),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Producer: ',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(movie.producer),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Release Year: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(movie.releaseDate),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Running Time: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${movie.runningTime} min'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Score: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(movie.rtScore),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.network(movie.image),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(movie.title),
                          content: Container(
                            child: Text(
                              movie.description,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
