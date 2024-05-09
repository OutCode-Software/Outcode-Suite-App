import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme_type.dart';

class AppThemeManager {
  factory AppThemeManager() {
    _instance ??= AppThemeManager._internal();
    return _instance!;
  }
  AppThemeManager._internal();
  static const appThemeKey = 'app_theme';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static AppThemeManager? _instance;
  AppThemeType currentAppTheme = AppThemeType.dark;
  Function()? onThemeChange;

  Future<void> setInitialTheme() async {
    final prefs = await _prefs;
    final savedThemeInt = prefs.getInt(appThemeKey) ?? 0;
    if (savedThemeInt == 0) {
      await changeTheme(AppThemeType.defaultTheme);
    } else if (savedThemeInt == 1) {
      await changeTheme(AppThemeType.light);
    } else {
      await changeTheme(AppThemeType.dark);
    }
  }

  Future<void> changeTheme(AppThemeType theme) async {
    final prefs = await _prefs;
    await prefs.setInt(appThemeKey, theme.key);
    if (theme != currentAppTheme) {
      currentAppTheme = theme;
      onThemeChange?.call();
    }
  }
}
