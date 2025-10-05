
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class Movie_detailRepositoryImp implements Movie_detailRepository{

        final Movie_detailRemoteDataSource remoteDataSource;
        Movie_detailRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    