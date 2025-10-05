class MovieEntity {
  final int id;
  final String posterPath;
  final String title;
  final String releaseDate;
  final String synopsis;
  final double rating;
  final List<String> genres;

  const MovieEntity({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.synopsis,
    required this.rating,
    required this.genres,
  });
}
