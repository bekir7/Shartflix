import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? studio;
  final String? director;
  final String? genres;
  final String? rating;
  final String? year;
  final bool? isFavorite;
  final String? trailerUrl;
  final String? duration; // in minutes
  final String? productionCompany;

  const MovieModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.studio,
    this.director,
    this.genres,
    this.rating,
    this.year,
    this.isFavorite,
    this.trailerUrl,
    this.duration,
    this.productionCompany,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Handle null-safe parsing
    String? parseToString(dynamic value) {
      if (value == null) return null;
      final str = value.toString();
      return str.isNotEmpty ? str : null;
    }

    bool? parseToBool(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is String) {
        return value.toLowerCase() == 'true' || value == '1';
      }
      if (value is int) return value == 1;
      return false;
    }

    // Convert HTTP URLs to HTTPS to avoid CORS issues
    String? convertToHttps(String? url) {
      if (url == null || url.isEmpty) return url;
      if (url.startsWith('http://')) {
        return url.replaceFirst('http://', 'https://');
      }
      return url;
    }

    final rawImageUrl = parseToString(json['Poster'] ?? json['posterUrl']);
    final imageUrl = convertToHttps(rawImageUrl);

    return MovieModel(
      id: parseToString(json['id'] ?? json['_id']),
      title: parseToString(json['Title'] ?? json['title']),
      description: parseToString(json['Plot'] ?? json['description']),
      imageUrl: imageUrl,
      studio: parseToString(json['Country'] ?? json['country']),
      director: parseToString(json['Director'] ?? json['director']),
      genres: parseToString(json['Genre'] ?? json['genres']),
      rating: parseToString(json['imdbRating'] ?? json['rating']),
      year: parseToString(json['Year'] ?? json['year']),
      isFavorite: parseToBool(json['isFavorite']),
      trailerUrl: parseToString(json['imdbID'] ?? json['trailerUrl']),
      duration: parseToString(json['Runtime'] ?? json['duration']),
      productionCompany:
          parseToString(json['Production'] ?? json['productionCompany']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'Title': title,
        'Plot': description,
        'Poster': imageUrl,
        'Country': studio,
        'Director': director,
        'Genre': genres,
        'imdbRating': rating,
        'Year': year,
        'isFavorite': isFavorite,
        'imdbID': trailerUrl,
        'Runtime': duration,
        'Production': productionCompany,
      };

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? studio,
    String? director,
    String? genres,
    String? rating,
    String? year,
    bool? isFavorite,
    String? trailerUrl,
    String? duration,
    String? productionCompany,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      studio: studio ?? this.studio,
      director: director ?? this.director,
      genres: genres ?? this.genres,
      rating: rating ?? this.rating,
      year: year ?? this.year,
      isFavorite: isFavorite ?? this.isFavorite,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      duration: duration ?? this.duration,
      productionCompany: productionCompany ?? this.productionCompany,
    );
  }

  @override
  List<Object?> get props => [
        id ?? '',
        title ?? '',
        description ?? '',
        imageUrl ?? '',
        studio ?? '',
        director ?? '',
        genres ?? '',
        rating ?? '',
        year ?? '',
        isFavorite,
        trailerUrl ?? '',
        duration ?? '',
        productionCompany ?? '',
      ];
}
