import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/domain/domain_models/app_info_domain.dart';
import '../app_version_info_view_type.dart';
import 'app_update_view.dart';

class AppUpdateDialogView extends StatelessWidget {
  const AppUpdateDialogView(
      {required this.viewType,
      required this.appInformation,
      this.onButtonClicked,
      super.key});

  final AppVersionInfoViewType viewType;
  final AppInfoDomain appInformation;
  final Function? onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.bottomSheetTheme.modalBarrierColor,
      child: Center(
        child: AppUpdateView(
          viewType: viewType,
          appInformation: appInformation,
          onButtonClicked: onButtonClicked,
        ),
      ),
    );
  }
}
