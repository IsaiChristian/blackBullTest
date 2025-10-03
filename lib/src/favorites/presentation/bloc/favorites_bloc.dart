
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'favorites_event.dart';
  part 'favorites_state.dart';
  
  class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
    FavoritesBloc() : super(FavoritesInitial()) {
      on<FavoritesEvent>((event, emit) {
        // TODO: implement event handler
      });
    }
  }
