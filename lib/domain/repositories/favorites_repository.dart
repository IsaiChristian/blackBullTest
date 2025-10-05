import 'package:black_bull/core/error/failure.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addMovieToFavorites(MovieEntity movie);
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies();
  Future<Either<Failure, void>> removeMovieFromFavorites(int movieId);
  Future<Either<Failure, bool>> isFavoriteMovie(int movieId);
}
