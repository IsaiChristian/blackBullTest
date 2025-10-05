import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:black_bull/data/repositories/favorites_repository_impl.dart';
import 'package:black_bull/core/error/failure.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';

import '../../mocks.mocks.mocks.dart';

void main() {
  late FavoriteRepositoryImpl repository;
  late MockLocalStorageService mockLocalStorage;

  const tKey = 'favorite_movies_list';
  final tMovie = MovieEntity(
    id: 1,
    title: 'Test Movie',
    posterPath: '/test.jpg',
    releaseDate: '2023-01-01',
    synopsis: 'A test movie',
    rating: 8.5,
    genres: ['Action', 'Drama'],
  );
  final tMovieList = [tMovie];

  setUp(() {
    mockLocalStorage = MockLocalStorageService();
    repository = FavoriteRepositoryImpl(mockLocalStorage);
  });

  group('getFavoriteMovies', () {
    test('should return list of favorite movies on success', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => tMovieList);

      final result = await repository.getFavoriteMovies();

      expect(result, Right(tMovieList));
      verify(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      );
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test('should return Failure when localStorage throws', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenThrow(Exception('error'));

      final result = await repository.getFavoriteMovies();

      expect(result.isLeft(), true);
    });
  });

  group('addMovieToFavorites', () {
    test('should add movie when not already in list', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => []);

      when(
        mockLocalStorage.setJsonList<MovieEntity>(tKey, any),
      ).thenAnswer((_) async => true);

      final result = await repository.addMovieToFavorites(tMovie);

      expect(result, isA<Right<Failure, void>>());
      verify(mockLocalStorage.setJsonList<MovieEntity>(tKey, [tMovie]));
    });

    test('should not add movie if already in favorites', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => [tMovie]);

      final result = await repository.addMovieToFavorites(tMovie);

      expect(result, isA<Right<Failure, void>>());
      verifyNever(mockLocalStorage.setJsonList<MovieEntity>(any, any));
    });
  });

  group('removeMovieFromFavorites', () {
    test('should remove movie if exists', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => [tMovie]);

      when(
        mockLocalStorage.setJsonList<MovieEntity>(tKey, []),
      ).thenAnswer((_) async => true);

      final result = await repository.removeMovieFromFavorites(tMovie.id);

      expect(result, isA<Right<Failure, void>>());
      verify(mockLocalStorage.setJsonList<MovieEntity>(tKey, []));
    });
  });

  group('isFavoriteMovie', () {
    test('should return true if movie exists', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => [tMovie]);

      final result = await repository.isFavoriteMovie(tMovie.id);

      expect(result, Right(true));
    });

    test('should return false if movie does not exist', () async {
      when(
        mockLocalStorage.getJsonList<MovieEntity>(tKey, MovieEntity.fromJson),
      ).thenAnswer((_) async => []);

      final result = await repository.isFavoriteMovie(tMovie.id);

      expect(result, Right(false));
    });
  });
}
