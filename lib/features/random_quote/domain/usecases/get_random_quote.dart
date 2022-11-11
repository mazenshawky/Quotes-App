import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/features/random_quote/domain/repositories/quote_repository.dart';

import '../../../../core/utils/error/failures.dart';
import '../entities/quote.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});

  @override
  Future<Either<Failure, Quote>> call(NoParams params) =>
      quoteRepository.getRandomQuote();
}
