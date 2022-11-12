import 'dart:convert';

import 'package:quotes_app/core/api/end_points.dart';
import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/features/random_quote/data/models/quote_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/app_strings.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  http.Client client;

  RandomQuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final randomQuoteUrl = Uri.parse(Endpoints.randomQuote);
    final response = await client.get(randomQuoteUrl,
        headers: {AppStrings.contentType: AppStrings.applicationJson});
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
