import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/random_quote/presentation/widgets/quote_content.dart';

import '../../../../core/utils/app_strings.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  Widget _buildBodyContent() {
    return Column(
      children: [
        QuoteContent(),
        Container(
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(AppStrings.appName),
    );
    return Scaffold(
      appBar: appBar,
      body: _buildBodyContent(),
    );
  }
}
