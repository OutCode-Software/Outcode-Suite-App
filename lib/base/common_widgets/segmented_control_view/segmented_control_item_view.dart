import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../base/common_widgets/segmented_control_view/segmented_control_item.dart';
import '../../utils/app_styles.dart';

@immutable
class SegmentedControlItemView extends StatelessWidget {
  const SegmentedControlItemView(
      {required this.item, this.onTapped, super.key});
  final SegmentedControlItem item;
  final Function(SegmentedControlItem)? onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped?.call(item);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: item.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppStyles.boldMedium(color: item.titleColor),
                ),
              ),
            ),
            Container(
              height: item.isSelected ? 1.5 : 0,
              color: context.theme.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
