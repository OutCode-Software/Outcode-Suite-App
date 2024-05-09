import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

@immutable
class TagView extends StatelessWidget {
  const TagView({required this.title, this.onTap, super.key});
  final String title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: context.colorScheme.primary.withAlpha(50),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Text(title,
                style: AppStyles.regularSmall(
                    color: context.colorScheme.primary)),
          ),
        ),
      ),
    );
  }
}
