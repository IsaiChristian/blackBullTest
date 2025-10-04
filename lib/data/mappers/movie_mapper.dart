import 'package:black_bull/data/models/movie_model.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';

extension MovieMapper on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      posterPath: posterPath,
      title: title,
      releaseDate: releaseDate,
      synopsis: overview,
      rating: voteAverage,
      genres: genreIds,
    );
  }
}

extension MovieListMapper on List<MovieModel> {
  List<MovieEntity> toEntityList() {
    return map((movie) => movie.toEntity()).toList();
  }
}
