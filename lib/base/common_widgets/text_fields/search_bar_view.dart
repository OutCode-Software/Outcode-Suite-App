import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../../base/common_widgets/text_fields/app_textfield.dart';

class SearchBarView extends StatefulWidget {
  const SearchBarView({this.onTap, super.key});
  final Function()? onTap;

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppTextField.textField(
        context: context,
        hint: 'SearchEclipsed'.localized,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.search,
            size: 20,
            color: context.colorScheme.onSecondary,
          ),
        ),
        onTap: widget.onTap,
        backgroundColor: context.colorScheme.onPrimary,
        validator: () {},
        controller: _searchController);
  }
}
