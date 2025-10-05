import 'package:black_bull/data/models/movie_detail_model.dart';
import 'package:black_bull/data/models/movie_model.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';

extension MovieMapper on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      posterPath: posterPath,
      title: title,
      releaseDate: releaseDate,
      synopsis: overview,
      rating: voteAverage,
      genres: [],
    );
  }
}

extension MovieListMapper on List<MovieModel> {
  List<MovieEntity> toEntityList() {
    return map((movie) => movie.toEntity()).toList();
  }
}

extension MovieDetailMapper on MovieDetail {
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      posterPath: posterPath!,
      title: title,
      releaseDate: releaseDate,
      synopsis:
          overview, // 'overview' from Movie maps to 'synopsis' in MovieEntity
      rating:
          voteAverage, // 'voteAverage' from Movie maps to 'rating' in MovieEntity
      genres: genres
          .map((genre) => genre.name)
          .toList(), // Extracting genre IDs
    );
  }
}

extension MovieDetailListMapper on List<MovieDetail> {
  List<MovieEntity> toEntityList() {
    return map((movie) => movie.toEntity()).toList();
  }
}
