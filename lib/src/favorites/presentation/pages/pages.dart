import 'package:black_bull/presentation/widgets/bb_app_bar.dart';
import 'package:black_bull/presentation/widgets/bb_movie_grid.dart' show BbMovieGrid;
import 'package:black_bull/src/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return FavoritesPageView();
      },
    );
  }
}

class FavoritesPageView extends StatelessWidget {
  const FavoritesPageView({super.key});

  @override
  Widget build(BuildContext context) {
        final currentState = context.watch<FavoritesBloc>().state;

    if (currentState is FavoritesLoaded) {
   
    return Scaffold(
      appBar: BbAppBar(),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            Padding(
              padding: .all(24),
              child: 
             BbMovieGrid(movieList: currentState.favoriteMovies),        
            ),
            
          ],
        ),
      ),
    );
  }
  if (currentState is FavoritesError) {
    return Scaffold(
      appBar: BbAppBar(),
      body: Center(
        child: Text('An error occurred. Please try again later.'),
      ),
    );
  }
  return SizedBox.shrink();
  }
}

