import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../app_button_state.dart';
import 'gola_bud_app_button_decorator.dart';

class PrimaryButtonDecorator extends AppButtonDecorator {
  PrimaryButtonDecorator({this.backgroundOpacity = 1});

  double backgroundOpacity = 1;

  @override
  Color getBackgroundColor(
      BuildContext context, AppButtonState appButtonState) {
    switch (appButtonState) {
      case AppButtonState.enabled:
        return context.theme.primaryColor;

      case AppButtonState.tapped:
        return context.theme.primaryColorDark;
      case AppButtonState.disabled:
        return context.theme.primaryColorLight;
    }
  }

  @override
  Color getTitleColor(AppButtonState appButtonState) {
    return AppColors.white;
  }
}
