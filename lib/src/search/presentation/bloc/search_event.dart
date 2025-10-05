part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class SearchSubmitted extends SearchEvent {
  final String query;
  SearchSubmitted(this.query);
}

class SearchTextChanged extends SearchEvent {
  final String query;
  SearchTextChanged(this.query);
}
