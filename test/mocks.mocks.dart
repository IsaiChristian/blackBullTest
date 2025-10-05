import 'package:black_bull/data/repositories/favorites_repository_impl.dart';
import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/src/app/bloc/app_bloc.dart';
import 'package:black_bull/src/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:black_bull/src/home/presentation/bloc/home_bloc.dart';
import 'package:black_bull/src/search/presentation/bloc/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:black_bull/core/services/local_storage_service.dart';

@GenerateMocks([LocalStorageService])
@GenerateMocks([MovieRepositoryImpl])
@GenerateMocks([FavoriteRepositoryImpl])
@GenerateMocks([AppBloc])
@GenerateMocks([FavoritesBloc])
@GenerateMocks([HomeBloc])
@GenerateMocks([SearchBloc])
@GenerateMocks([Dio])
void main() {}
