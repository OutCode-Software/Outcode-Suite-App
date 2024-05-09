import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import 'tag_view.dart';

@immutable
class EmptyStateView extends StatelessWidget {
  const EmptyStateView(
      {required this.tags,
      this.imageString,
      this.title,
      this.detailText,
      this.backgroundColor,
      this.fraction,
      super.key});
  final String? imageString;
  final String? title;
  final String? detailText;
  final double? fraction;
  final List<TagView> tags;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          imageString == null
              ? const SizedBox.shrink()
              : FractionallySizedBox(
                  widthFactor: fraction ?? 0.5,
                  child: Image(image: AssetImage(imageString!))),
          Visibility(
            visible: title != null,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10, top: imageString == null ? 0 : 10),
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.onSecondary),
              ),
            ),
          ),
          Visibility(
            visible: detailText != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                detailText ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: tags,
            ),
          )
        ]),
      ),
    );
  }
}
