class MovieEntity {
  final String posterPath;
  final String title;
  final String releaseDate;
  final String synopsis;
  final double rating;
  final List<int> genres;

  const MovieEntity({
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.synopsis,
    required this.rating,
    required this.genres,
  });
}
