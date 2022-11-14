import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes_app/bloc_observer.dart';
import 'package:quotes_app/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes_app/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes_app/features/random_quote/data/repositories/quote_repository_impl.dart';
import 'package:quotes_app/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:quotes_app/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quotes_app/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteRemoteDataSource: sl(),
      randomQuoteLocalDataSource: sl()));

  // Data Soruces
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppBlocObserver());
}
