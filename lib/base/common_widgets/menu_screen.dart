import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/core/domain/domain_models/menu_option.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen(
      {required this.options,
      this.backgroundColor,
      this.separatorColor,
      this.pullDownColor,
      this.separatorMargin = EdgeInsets.zero,
      this.extraSpacePadding,
      this.header,
      this.footer,
      super.key});

  final List<MenuOption> options;
  final Widget? header;
  final Widget? footer;
  final Color? backgroundColor;
  final Color? separatorColor;
  final EdgeInsets separatorMargin;
  final Color? pullDownColor;
  final double? extraSpacePadding;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final viewHeight = options.length * 50 + 100 + (extraSpacePadding ?? 0);
    final height = viewHeight > maxHeight ? maxHeight : viewHeight;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height.toDouble()),
        child: Container(
          padding: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: backgroundColor ?? context.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 5,
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                      color: pullDownColor ?? context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  width: 50,
                  height: 5,
                )),
              ),
              if (header != null) header!,
              Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return options[index].widget(
                          context: context,
                          seperatorColor:
                              context.colorScheme.onTertiary,
                          seperatorMargin: separatorMargin);
                    }),
              ),
              if (footer != null) footer!
            ],
          ),
        ),
      ),
    );
  }
}
