import 'package:flutter/material.dart';
import '../../../base/common_widgets/navbar/nav_bar.dart';
import '../../../base/utils/colors.dart';
import 'app_information_view/app_Version_info_view.dart';
import 'app_information_view/app_version_info_view_type.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AboutAppScreen());
  }
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _navBar(),
          const AppVersionInfoView(
            viewType: AppVersionInfoViewType.normal,
          )
        ],
      ),
    );
  }

  Widget _navBar() {
    return NavBar(
      navStyle: NavStyle.doubleLined,
      navTitle: 'AboutAppScreen_navTitle',
      title: 'AboutAppScreen_title',
      backgroundColor: AppColors.transparent,
      showsLeftButton: true,
      onBackButtonClicked: () {
        Navigator.pop(context);
      },
      leftButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {},
      ),
    );
  }
}
