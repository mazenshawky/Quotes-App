import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/app.dart';

import 'injection_container.dart' as di;
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = di.sl<AppBlocObserver>();
  runApp(const QuoteApp());
}
