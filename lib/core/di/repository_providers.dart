import 'package:black_bull/core/network/dio_client.dart';
import 'package:black_bull/core/services/local_storage_service.dart';
import 'package:black_bull/data/repositories/favorites_repository_impl.dart';
import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/src/app/bloc/app_bloc.dart';
import 'package:black_bull/src/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> repositoryProviders = [
  RepositoryProvider(
    create: (context) => MovieRepositoryImpl(
      context.read<DioClient>().dio,
    ), // Provide Dio instance here
  ),
  RepositoryProvider(
    create: (context) =>
        FavoriteRepositoryImpl(context.read<LocalStorageService>()),
  ),
];
List<SingleChildWidget> appWideProviders = [
  BlocProvider(create: (context) => AppBloc()),
  BlocProvider(
    create: (context) => FavoritesBloc(
      favoriteRepositoryImpl: context.read<FavoriteRepositoryImpl>(),
    )..add(LoadFavorites()),
  ),
];
