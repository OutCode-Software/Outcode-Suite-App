import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';

class SignUpTermsAgreeView extends StatefulWidget {
  const SignUpTermsAgreeView({required this.onSelectionChanged, super.key});
  final Function(bool)? onSelectionChanged;

  @override
  State<SignUpTermsAgreeView> createState() => _SignUpTermsAgreeViewState();
}

class _SignUpTermsAgreeViewState extends State<SignUpTermsAgreeView> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _isSelected = !_isSelected;
              setState(() {});
              widget.onSelectionChanged?.call(_isSelected);
            },
            icon: Icon(
              _isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: _isSelected
                  ? context.theme.primaryColor
                  : context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
              child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: 'ClickToAgreeStatement'.localized,
                      style: TextStyle(
                          color: context.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      children: <InlineSpan>[
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                        ),
                        TextSpan(
                          text: 'LowerCaseTermsAndConditions'.localized,
                          style: TextStyle(
                              color: context.colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text('.',
                                style: TextStyle(
                                    color:
                                        context.colorScheme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ]))),
        ],
      ),
    );
  }
}
