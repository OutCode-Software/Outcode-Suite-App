import 'package:flutter/material.dart';

import '../base/common_widgets/image_widgets/app_image_view.dart';
import '../base/constants/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: ColoredBox(
          color: Colors.red,
          child: AppImageView(
              initialsText: Constants.appName, height: 200, width: 200)),
    ));
  }
}
