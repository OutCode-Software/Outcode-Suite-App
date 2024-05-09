import 'package:flutter/material.dart';

import 'open_view_type.dart';
import 'pop_over_content_model_domain.dart';
import 'pop_over_info_view_content.dart';

class PopOverInfoViewUtil {
  static void showPopOver(BuildContext context, PopOverContentModelDomain model,
      Function(PopUpOpenViewType)? openViewType) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopOverInfoViewContent(
          model: model,
          onOpenViewType: openViewType,
        );
      },
    );
  }
}
