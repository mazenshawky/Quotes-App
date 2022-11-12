import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/random_quote/domain/entities/quote.dart';

import '../../../../core/error/failures.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
