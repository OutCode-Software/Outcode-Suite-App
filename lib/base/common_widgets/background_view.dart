import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

@immutable
class BackgroundView extends StatelessWidget {
  const BackgroundView(
      {required this.image,
      super.key,
      this.overlayColor = AppColors.transparent,
      this.opacity = 0.7});
  final String image;
  final Color? overlayColor;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: context.theme.scaffoldBackgroundColor,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: overlayColor,
                backgroundBlendMode: BlendMode.multiply,
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}
