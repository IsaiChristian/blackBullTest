import 'package:black_bull/core/error/failure.dart';
import 'package:black_bull/data/mappers/popular_movies_mapper.dart';
import 'package:black_bull/data/mappers/search_response_mapper.dart';
import 'package:black_bull/data/models/popular_movies_model.dart';
import 'package:black_bull/data/models/search_response_model.dart';
import 'package:black_bull/domain/entities/popular_movies_entity.dart';
import 'package:black_bull/domain/entities/search_response_entity.dart';
import 'package:black_bull/domain/repositories/movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, PopularMoviesResponseEntity>> getPopularMovies({
    int page = 1,
  }) async {
    try {
      print("Fetching popular movies, page $page");
      final response = await dio.get(
        "/movie/popular",
        queryParameters: {"page": page},
      );

      final model = PopularMoviesResponseModel.fromJson(response.data);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message!));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchResponseEntity>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        "/search/movie",
        queryParameters: {"query": query, "page": page},
      );

      final model = SearchResponseModel.fromJson(response.data);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message!));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
