import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/presentation/widgets/bb_movie_grid.dart';
import 'package:black_bull/src/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(movieRepository: context.read<MovieRepositoryImpl>()),
      child: SearchPageView(),
    );
  }
}

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          bool showResults = state is SearchLoaded;
          double inputHeight = 60.0; // Height of your search input
          double initialPageHeigh = 160.0; // Height of your search input

          return SafeArea(
            child: Stack(
              children: [
                // Search Input Field (Animated Position)
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  top: showResults
                      ? 0
                      : MediaQuery.of(context).size.height / 2 -
                            initialPageHeigh / 2,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/BlackBull_w.svg',
                        height: 32,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: inputHeight,
                        alignment: showResults
                            ? Alignment.topLeft
                            : Alignment.center,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for movies...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onChanged: (query) {
                            context.read<SearchBloc>().add(
                              SearchSubmitted(query),
                            );
                          },
                          onSubmitted: (query) {
                            context.read<SearchBloc>().add(
                              SearchSubmitted(query),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Movie Results Grid
                if (showResults)
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    top: inputHeight + 60, // <--- Define la posición superior
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: BbMovieGrid(movieList: state.movies),
                    ),
                  ),

                // Loading Indicator
                if (state is SearchLoading)
                  Center(child: CircularProgressIndicator()),

                // Error Message
                if (state is SearchError)
                  Center(child: Text('Error: ${state.message}')),

                // Initial Message / Placeholder
              ],
            ),
          );
        },
      ),
    );
  }
}
