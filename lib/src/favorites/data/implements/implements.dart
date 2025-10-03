
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class FavoritesRepositoryImp implements FavoritesRepository{

        final FavoritesRemoteDataSource remoteDataSource;
        FavoritesRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    