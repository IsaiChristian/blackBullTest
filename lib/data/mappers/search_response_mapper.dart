import 'package:black_bull/data/mappers/movie_mapper.dart';
import 'package:black_bull/data/models/search_response_model.dart';
import 'package:black_bull/domain/entities/search_response_entity.dart';

extension SearchResponseMapper on SearchResponseModel {
  SearchResponseEntity toEntity() {
    return SearchResponseEntity(
      page: page,
      results: results.toEntityList(),
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
