import 'dart:async';

import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/domain/entities/movie_entity.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepositoryImpl movieRepository;
  HomeBloc({required this.movieRepository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomeInit>(_homeInit);
    on<HomeShowLoading>(_showLoading, transformer: droppable());
    on<HomeLoadMore>(_homeLoadMore, transformer: droppable());
  }

  FutureOr<void> _homeInit(HomeInit event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final popularMovies = await movieRepository.getPopularMovies();
    await Future.delayed(Duration(seconds: 2));
    popularMovies.fold(
      (l) => emit(HomeError()),
      (r) => emit(
        HomeReady(movies: r.results, page: r.page, totalPages: r.totalPages),
      ),
    );
  }

  FutureOr<void> _homeLoadMore(
    HomeLoadMore event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeReady) return;
    final homeReadyState = state as HomeReady;
    final nextPage = homeReadyState.page + 1;

    final newMovies = await movieRepository.getPopularMovies(page: nextPage);

    newMovies.fold((l) => emit(HomeError()), (r) {
      final updatedMovies = List<MovieEntity>.from(homeReadyState.movies)
        ..addAll(r.results);

      emit(
        HomeReady(
          movies: updatedMovies,
          page: r.page,
          totalPages: r.totalPages,
          isLoadingMore: false,
        ),
      );
    });
  }

  FutureOr<void> _showLoading(
    HomeShowLoading event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeReady) return;
    final homeReadyState = state as HomeReady;
    emit(
      HomeReady(
        movies: homeReadyState.movies,
        page: homeReadyState.page,
        totalPages: homeReadyState.totalPages,
        isLoadingMore: true,
      ),
    );
  }
}
