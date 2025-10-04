import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/presentation/widgets/bb_app_bar.dart';
import 'package:black_bull/presentation/widgets/bb_loading_logo.dart';
import 'package:black_bull/src/home/presentation/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
         movieRepository: context.read<MovieRepositoryImpl>(),
      )..add(HomeInit()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return HomePageView(
            
          );
        },
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
  
}

class _HomePageViewState extends State<HomePageView> {
    final ScrollController _scrollController = ScrollController();

   @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Debounce to prevent multiple rapid calls
        context.read<HomeBloc>().add(HomeShowLoading());
      
      
        context.read<HomeBloc>().add(HomeLoadMore());
      
    }
  }

  @override
  void dispose() {
    
    _scrollController.dispose();
    super.dispose();
  }
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
 
}
  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<HomeBloc>().state;

    if (currentState is HomeLoading || currentState is HomeInitial) {
      return Column(
        children: [
          Expanded(child: BbLoadingLogo()),
        ],
      );
    }
if (currentState is HomeReady) {
   
    return Scaffold(
      appBar: BbAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: .all(24),
              child: 
             GridView.builder(
              shrinkWrap: true, // <- evita que tome altura infinita
          physics: NeverScrollableScrollPhysics(), // <- evita doble scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ), 
                itemCount: currentState.movies.length , 
                itemBuilder: (context, index) {
                 
                  return Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                 height: double.infinity,
                                  color: Colors.grey[400],
                                  child: Icon(Icons.movie, size: 64, color: Colors.grey[700]),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w154${currentState.movies[index].posterPath}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: BbLoadingLogo(onlyIcon: true, duration: Duration(microseconds: 300),)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                          
                            ],
                          ),
                        ),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            currentState.movies[index].title, // replace with movie title
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),        
            ),
            if (currentState.isLoadingMore)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BbLoadingLogo(),
              ),
          ],
        ),
      ),
    );
  }
  if (currentState is HomeError) {
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


