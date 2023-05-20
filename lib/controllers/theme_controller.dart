import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
