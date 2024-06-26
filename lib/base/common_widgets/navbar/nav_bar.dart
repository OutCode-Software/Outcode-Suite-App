import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/strings.dart';

enum NavStyle { singleLined, doubleLined }

extension NavStyleExtension on NavStyle {
  MainAxisAlignment get alignment {
    switch (this) {
      case NavStyle.singleLined:
        return MainAxisAlignment.start;
      case NavStyle.doubleLined:
        return MainAxisAlignment.spaceBetween;
    }
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    required this.navStyle,
    this.leftButton,
    this.navTitle = '',
    this.title,
    this.backgroundColor,
    this.showsLeftButton = false,
    this.textColor,
    this.isTitleCenterAligned = true,
    this.onBackButtonClicked,
    this.sideMenuItems,
    this.hasCornerRadius = false,
    this.leftButtonWidth = 50,
    this.subWidget,
    super.key,
  });
  final String navTitle;
  final String? title;
  final bool showsLeftButton;
  final Function()? onBackButtonClicked;
  final List<Widget>? sideMenuItems;
  final Color? backgroundColor;
  final NavStyle navStyle;
  final Widget? leftButton;
  final bool isTitleCenterAligned;
  final Color? textColor;
  final bool hasCornerRadius;
  final double leftButtonWidth;
  final Widget? subWidget;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: backgroundColor ??
              context.theme.navigationBarTheme.backgroundColor,
          borderRadius: hasCornerRadius
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
              : null),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _navComponent(context),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        (title ?? '').localized,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                color: textColor ??
                                    context.colorScheme.onPrimary),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _navComponent(BuildContext context) {
    return navStyle == NavStyle.singleLined
        ? _singleLinedWrapper(context)
        : _doubleLinedWrapper(context);
  }

  Widget _singleLinedWrapper(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: leftButtonWidth,
            child: Visibility(
              visible: leftButton != null,
              child: leftButton ?? Container(),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isTitleCenterAligned
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  navTitle.localized,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: title == null
                      ? context.textTheme.headlineLarge?.copyWith(
                          color: textColor ??
                              context.colorScheme.onPrimary)
                      : AppStyles.boldLarge(
                          color: textColor ??
                              context.colorScheme.onPrimary),
                ),
                if (subWidget != null) subWidget!
              ],
            ),
          ),
          _sideMenus()
        ],
      ),
    );
  }

  Widget _doubleLinedWrapper(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(children: [
            SizedBox(
              width: 30,
              child: Visibility(
                visible: showsLeftButton,
                child: IconButton(
                    onPressed: () {
                      onBackButtonClicked?.call();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: context.colorScheme.primary,
                    )),
              ),
            ),
            Expanded(
              child: Text(
                navTitle.localized,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: title == null
                    ? context.textTheme.headlineLarge
                    : AppStyles.boldLarge(
                        color: context.colorScheme.primary),
              ),
            ),
          ]),
        ),
        _sideMenus()
      ],
    );
  }

  Widget _sideMenus() {
    return (sideMenuItems ?? []).isEmpty
        ? const SizedBox(
            width: 50,
          )
        : Row(
            children: sideMenuItems ?? [],
          );
  }
}
