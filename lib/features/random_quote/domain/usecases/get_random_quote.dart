import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/usecases/usecase.dart';

import '../../../../core/utils/error/failures.dart';
import '../entities/quote.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
