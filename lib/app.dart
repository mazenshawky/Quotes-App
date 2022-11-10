import 'package:flutter/material.dart';
import 'package:quotes_app/config/themes/app_theme.dart';
import 'package:quotes_app/core/utils/app_strings.dart';

import 'config/routes/app_routes.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
