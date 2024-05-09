import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../base/utils/app_styles.dart';

class AccessoryBar extends StatelessWidget {
  const AccessoryBar(
      {required this.title,
      this.doneText,
      this.cancelTitle = 'Cancel',
      this.onCancelPressed,
      this.onDonePressed,
      this.canPressDone = true,
      super.key});
  final String cancelTitle;
  final String title;
  final String? doneText;
  final Function()? onCancelPressed;
  final Function()? onDonePressed;
  final bool canPressDone;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onCancelPressed,
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    cancelTitle,
                    style: AppStyles.regularSmall(
                        color: context.theme.primaryColor),
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: AppStyles.boldMedium(
                  color: context.colorScheme.onPrimary),
            ),
            GestureDetector(
              onTap: canPressDone ? onDonePressed : null,
              child: SizedBox(
                width: 70,
                child: Visibility(
                  visible: doneText != null,
                  child: Center(
                    child: Text(doneText ?? '',
                        style: AppStyles.regularSmall(
                            color: canPressDone
                                ? context.theme.primaryColor
                                : context.colorScheme.tertiary)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
