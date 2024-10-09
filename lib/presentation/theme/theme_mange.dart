import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier{
  bool _isDark=false;
  set toggleTheme(bool value) {
    _isDark =value;
    notifyListeners();
  }
  bool get toggleTheme{
     return _isDark;
  }
  }
