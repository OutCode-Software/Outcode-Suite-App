import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/common_widgets/buttons/app_button.dart';
import 'package:app/base/common_widgets/text_fields/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: '/login'),
        builder: (_) => const LoginScreen());
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppTextField.textField(
                  context: context,
                  hint: "Email",
                  validator: () {
                    return null;
                  },
                  controller: _emailController),
              const SizedBox(
                height: 12,
              ),
              AppTextField.textField(
                  context: context,
                  hint: "Password",
                  validator: () {
                    return null;
                  },
                  controller: _passwordController),
              const SizedBox(
                height: 12,
              ),
              AppButton(title: "Login", onClick: () {}),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
