import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import '../buttons/app_button.dart';

class Alert {
  void showAlert(
      {required BuildContext context,
      String? message,
      Widget? actionWidget,
      String? title,
      Color? backgroundColor,
      double cornerRadius = 10,
      Color titleColor = AppColors.white,
      TextAlign titleAlign = TextAlign.left,
      Color messageColor = AppColors.white,
      Color barrierColor = Colors.black54,
      bool isWarningAlert = false,
      Widget? tertiaryWidget}) {
    showDialog(
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return Material(
          color: AppColors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.theme.dialogBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                title,
                                textAlign: titleAlign,
                                style: AppStyles.boldMedium(color: titleColor),
                              ),
                            )
                          : Container(),
                      if (isWarningAlert)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Warning'.localized,
                            style: AppStyles.regularLarge(
                                color: context.colorScheme.onError),
                          ),
                        ),
                      if (message != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(message,
                              style:
                                  AppStyles.regularSmall(color: messageColor)),
                        ),
                      if (tertiaryWidget != null) tertiaryWidget,
                      if (actionWidget != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: actionWidget,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getDefaultTwoButtons(
      {required BuildContext context,
      required String firstButtonTitle,
      required String lastButtonTitle,
      required Function()? onFirstButtonClick,
      required Function()? onLastButtonClick}) {
    return Row(
      children: [
        Expanded(
            child: AppButton(
          title: firstButtonTitle,
          height: 35,
          onClick: onFirstButtonClick,
          border: BorderSide(
              color: context.colorScheme.primary, width: 2),
          backgroundColor: AppColors.transparent,
          elevation: 0,
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: AppButton(
          title: lastButtonTitle,
          height: 35,
          onClick: onLastButtonClick,
          elevation: 0,
        ))
      ],
    );
  }
}
