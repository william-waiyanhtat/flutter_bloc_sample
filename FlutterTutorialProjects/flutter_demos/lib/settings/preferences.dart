import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'app_themes.dart';

class Preferences {
  //
  static SharedPreferences prefs;
  static const String KEY_SELECTED_THEME = 'key_selected_theme';

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveTheme(AppTheme selectedTheme) async {
    if (null == selectedTheme) {
      selectedTheme = AppTheme.lightTheme;
      return;
    }
    String theme = jsonEncode(selectedTheme.toString());
    prefs.setString(KEY_SELECTED_THEME, theme);
  }

  static AppTheme getTheme() {
    String theme = prefs.getString(KEY_SELECTED_THEME);
    if (null == theme) {
      return AppTheme.lightTheme;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static AppTheme getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
