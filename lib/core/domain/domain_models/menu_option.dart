import 'package:flutter/material.dart';

class MenuOption {
  MenuOption(
      {required this.title,
      required this.icon,
      required this.itemColor,
      required this.onTapped,
      required this.item});
  final String title;
  final Widget icon;
  final Color itemColor;
  final Function(MenuOption) onTapped;
  final dynamic item;

  Widget widget(
      {required BuildContext context,
      required Color seperatorColor,
      required EdgeInsetsGeometry seperatorMargin}) {
    return GestureDetector(
      onTap: () {
        onTapped.call(this);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: itemColor))
                ],
              ),
            ),
            Container(
              margin: seperatorMargin,
              height: 0.5,
              color: seperatorColor,
            )
          ],
        ),
      ),
    );
  }
}
