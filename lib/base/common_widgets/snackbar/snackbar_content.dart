import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common_widgets/snackbar/snackbar_style.dart';
import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class SnackBarContent extends StatelessWidget {
  const SnackBarContent(
      {required this.message, required this.style, super.key});
  final String message;
  final SnackbarStyle style;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: style.displayBackgroundColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 17, bottom: 17),
              child: Text(
                message,
                style: AppStyles.regularSmall(color: style.displayTitleColor),
              ),
            ),
          ),
          Visibility(
            visible: style != SnackbarStyle.validationError,
            child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.xmark,
                  color: AppColors.transparent,
                )),
          )
        ],
      ),
    );
  }
}
