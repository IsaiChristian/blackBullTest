import 'package:black_bull/core/error/failure.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';
import 'package:black_bull/domain/entities/popular_movies_entity.dart';
import 'package:black_bull/domain/entities/search_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, PopularMoviesResponseEntity>> getPopularMovies({
    int page = 1,
  });
  Future<Either<Failure, SearchResponseEntity>> searchMovies({
    required String query,
    int page = 1,
  });
  Future<Either<Failure, MovieEntity>> getMovie({required int id});
}
