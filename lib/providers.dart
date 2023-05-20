import 'package:dictionary_app/controllers/search_controller.dart';
import 'package:dictionary_app/controllers/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = ChangeNotifierProvider<SearchProvider>(
  (ref) => SearchProvider(),
);

final themeProvider = ChangeNotifierProvider(
  (ref) => ThemeProvider(),
);
