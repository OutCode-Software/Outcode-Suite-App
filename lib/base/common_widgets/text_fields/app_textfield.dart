import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_styles.dart';
import '../../utils/colors.dart';

class AppTextField {
  AppTextField._();

  static Widget textField(
      {required BuildContext context,
      required String hint,
      required String? Function() validator,
      required TextEditingController controller,
      Color? backgroundColor = AppColors.white,
      Function(String)? onTextChanged,
      Function(String)? onFieldSubmitted,
      Function()? onTap,
      TextInputType keyboardType = TextInputType.text,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      Function? onObscureTapped,
      bool isPasswordField = false,
      bool isObscured = false,
      bool disablesEmojis = true,
      int? maxLines = 1,
      int maxLength = 255,
      double verticalPadding = 12,
      bool isDisabled = false,
      bool isRequired = false,
      List<TextInputFormatter>? inputFormatters,
      String? headerTitle,
      Widget? suffixIcon,
      Widget? prefixIcon,
      FocusNode? focusNode,
      Color titleColor = AppColors.white,
      double borderRadius = 50.0,
      Color? textColor,
      bool hasError = false}) {
    final formatters = <TextInputFormatter>[];
    if (disablesEmojis) {
      formatters.add(FilteringTextInputFormatter.deny(RegExp('''
(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])''')));
    }
    inputFormatters?.forEach(formatters.add);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: AppStyles.textFieldTextStyle(
              color: textColor ?? context.colorScheme.secondary),
          validator: (value) => validator.call(),
          onChanged: onTextChanged,
          focusNode: focusNode,
          obscureText: isObscured,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          maxLength: maxLength,
          autocorrect: false,
          onTap: onTap,
          maxLines: maxLines,
          readOnly: isDisabled,
          inputFormatters: formatters,
          decoration: InputDecoration(
            counterText: '',
            fillColor: backgroundColor,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: (suffixIcon != null || prefixIcon != null)
                    ? 5
                    : verticalPadding),
            labelText: hint.localized,
            hintStyle: context.textTheme.labelSmall
                ?.copyWith(color: context.colorScheme.secondary),
            labelStyle: context.textTheme.labelSmall
                ?.copyWith(color: context.colorScheme.secondary),
            border: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderRadius: borderRadius),
            enabledBorder: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderRadius: borderRadius),
            focusedBorder: AppStyles.outlinedInputBorder(
                hasValidationError: hasError, borderRadius: borderRadius),
          ),
        ),
      ],
    );
  }
}
