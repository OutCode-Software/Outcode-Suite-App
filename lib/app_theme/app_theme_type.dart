enum AppThemeType {
  defaultTheme,
  light,
  dark;

  int get key {
    switch (this) {
      case AppThemeType.defaultTheme:
        return 0;
      case AppThemeType.light:
        return 1;
      default:
        return 2;
    }
  }
}
