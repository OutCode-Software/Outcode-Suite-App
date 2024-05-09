import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../base/utils/strings.dart';

class BottomSheetHeaderView extends StatelessWidget {
  const BottomSheetHeaderView(
      {required this.title, this.onclosePressed, super.key});
  final String title;
  final Function? onclosePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title.localized,
            style: context.textTheme.headlineLarge,
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              color: context.colorScheme.primary,
            ))
      ],
    );
  }
}
