import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/strings.dart';
import '../buttons/app_button.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet(
      {required this.title, required this.actionItems, super.key});
  final String title;
  final List<Widget> actionItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(),
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title.localized,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(actionItems.length, (index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 0.5,
                                  child:
                                      Container(color: AppColors.primaryLight),
                                ),
                                actionItems[index]
                              ],
                            );
                          }),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppButton(
                    title: 'Cancel'.localized,
                    textColor: AppColors.accent1Dark,
                    backgroundColor: AppColors.white,
                    onClick: () {
                      Navigator.pop(context);
                    })
              ])
            ],
          ),
        ),
      ),
    );
  }
}
