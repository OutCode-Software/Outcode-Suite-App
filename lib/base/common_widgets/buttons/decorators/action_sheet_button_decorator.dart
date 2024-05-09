import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../app_button_state.dart';
import 'gola_bud_app_button_decorator.dart';

class ActionSheetButtonDecorator extends AppButtonDecorator {
  double backgroundOpacity = 1;
  @override
  Color getBackgroundColor(
      BuildContext context, AppButtonState appButtonState) {
    switch (appButtonState) {
      case AppButtonState.enabled:
        return AppColors.secondaryLight;
      case AppButtonState.tapped:
        return AppColors.secondaryLight;
      case AppButtonState.disabled:
        return AppColors.secondaryLight;
    }
  }

  @override
  Color getTitleColor(AppButtonState appButtonState) {
    return AppColors.primaryDark;
  }
}
