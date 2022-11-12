import 'package:quotes_app/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}
