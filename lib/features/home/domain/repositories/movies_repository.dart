import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class MoviesRepository {
  Future<Either<Failure, Map<String, dynamic>>> getMovies(int page, int limit);
  Future<Either<Failure, void>> toggleFavorite(String movieId);
}
