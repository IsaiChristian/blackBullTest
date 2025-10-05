import 'package:black_bull/domain/entities/movie_entity.dart';
import 'package:black_bull/src/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMovie extends StatelessWidget {
  final MovieEntity movie;
  const FavoriteMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          FavoritesLoaded currentState = state;
          isFavorite = currentState.favoriteMovies.any(
            (favMovie) => favMovie.id == movie.id,
          );
        }
        return FloatingActionButton(
          onPressed: () {
            !isFavorite
                ? context.read<FavoritesBloc>().add(AddFavoriteMovie(movie))
                : context.read<FavoritesBloc>().add(RemoveFavoriteMovie(movie));
          },
          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        );
      },
    );
  }
}
