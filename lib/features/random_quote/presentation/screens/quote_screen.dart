import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes_app/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:quotes_app/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes_app/features/splash/presentation/cubit/locale_cubit.dart';

import '../../../../config/locale/app_localizations.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: (context, state) {
      if (state is RandomQuoteisLoading) {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      } else if (state is RandomQuoteError) {
        return error_widget.ErrorWidget(
          onPress: () => _getRandomQuote(),
        );
      } else if (state is RandomQuoteLoaded) {
        return Column(
          children: [
            QuoteContent(
              quote: state.quote,
            ),
            InkWell(
              onTap: () {
                _getRandomQuote();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.refresh,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      } else {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
          onPressed: () {
            if (AppLocalizations.of(context)!.isEnLocale) {
              BlocProvider.of<LocaleCubit>(context).toArabic();
            } else {
              BlocProvider.of<LocaleCubit>(context).toEnglish();
            }
          },
          icon: Icon(
            Icons.translate_outlined,
            color: AppColors.primary,
          )),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
    return RefreshIndicator(
        child: Scaffold(
          appBar: appBar,
          body: _buildBodyContent(),
        ),
        onRefresh: () => _getRandomQuote());
  }
}
