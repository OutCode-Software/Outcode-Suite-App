import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/constants/constants.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../base/common_widgets/image_widgets/app_image_view.dart';
import '../../../../base/utils/colors.dart';

enum AppVersionInfoViewType { normal, dialog }

extension AppVersionInfoViewTypeExtension on AppVersionInfoViewType {
  String get headerTitle {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return Constants.appName;
      case AppVersionInfoViewType.dialog:
        return 'UpdateAvailable'.localized;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return Colors.transparent;
      case AppVersionInfoViewType.dialog:
        return AppColors.white;
    }
  }

  Widget get imageWidget {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return const AppImageView(
          height: 80,
          width: 80,
        );
      case AppVersionInfoViewType.dialog:
        return Lottie.asset('assets/lottie/logoAnimate.json',
            width: 500, repeat: true);
    }
  }

  Widget? detail(BuildContext context) {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return null;
      case AppVersionInfoViewType.dialog:
        return Text(
          'AccessLatestAppInfo'.localized,
          style: context.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        );
    }
  }

  bool get showsUpdateButton {
    switch (this) {
      case AppVersionInfoViewType.normal:
        return true;
      case AppVersionInfoViewType.dialog:
        return true;
    }
  }
}
