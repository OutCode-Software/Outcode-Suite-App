import 'package:flutter/material.dart';

import '../../utils/colors.dart';

enum SnackbarStyle { error, success, normal, validationError }

extension SnackbarStyleExtension on SnackbarStyle {
  Color get displayTitleColor {
    switch (this) {
      case SnackbarStyle.error:
        return AppColors.errorDark;
      case SnackbarStyle.success:
        return AppColors.white;
      case SnackbarStyle.normal:
        return AppColors.white;
      case SnackbarStyle.validationError:
        return AppColors.white;
    }
  }

  Color get displayBackgroundColor {
    switch (this) {
      case SnackbarStyle.error:
        return AppColors.errorDark;
      case SnackbarStyle.success:
        return Colors.green;
      case SnackbarStyle.normal:
        return AppColors.primaryDark;
      case SnackbarStyle.validationError:
        return AppColors.errorDark;
    }
  }
}
