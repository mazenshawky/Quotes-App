import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_quote/domain/usecases/get_random_quote.dart';

import '../../domain/entities/quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    emit(RandomQuoteisLoading());
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    // or you can use
    // getRandomQuoteUseCase.call(NoParams());

    emit(response.fold(
        (failure) => RandomQuoteError(msg: _mapFailureToMsg(failure)),
        (quote) => RandomQuoteLoaded(quote: quote)));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
