import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../base/common_widgets/buttons/app_button.dart';
import '../../../../../core/domain/domain_models/app_info_domain.dart';
import '../app_version_info_view_type.dart';

class AppUpdateView extends StatelessWidget {
  const AppUpdateView(
      {required this.viewType,
      required this.appInformation,
      this.onButtonClicked,
      super.key});
  final AppVersionInfoViewType viewType;
  final AppInfoDomain appInformation;
  final Function? onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: viewType.backgroundColor),
            child: Column(children: [
              Text(
                viewType.headerTitle,
                style: context.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: appInformation.showsAppIcon,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: viewType.imageWidget,
                ),
              ),
              Visibility(
                visible: viewType.detail(context) != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: viewType.detail(context) ?? Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Version ${appInformation.versionName} (build ${appInformation.buildNumber})',
                  style: context.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  !appInformation.hasAppUpdate
                      ? 'Up to Date!'
                      : 'A new version is available!',
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible:
                    appInformation.hasAppUpdate && viewType.showsUpdateButton,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 8),
                  child: AppButton(
                      title: 'Update Now',
                      onClick: () {
                        Navigator.pop(context);
                        onButtonClicked?.call();
                        _openAppStore(context);
                      }),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  void _openAppStore(BuildContext context) {
    if ((appInformation.link ?? '').isNotEmpty) {
      launchUrlString(appInformation.link!,
          mode: LaunchMode.externalApplication);
    }
  }
}
