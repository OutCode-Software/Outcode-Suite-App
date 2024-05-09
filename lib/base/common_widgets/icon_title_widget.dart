import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class IconTitleWidget extends StatelessWidget {
  IconTitleWidget(
      {required this.icon,
      required this.title,
      this.textStyle,
      this.padding = 5,
      super.key});

  final Widget icon;
  final String title;
  TextStyle? textStyle;
  double padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: padding,
        ),
        Text(title,
            style: textStyle ??
                TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.theme.primaryColor))
      ],
    );
  }
}
