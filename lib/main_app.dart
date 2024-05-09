import 'package:app/app_theme/app_theme.dart';
import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outcode_package/functionalities/app_switcher_protection/app_switcher_protection.dart';
import 'package:outcode_package/functionalities/app_version_checker/app_version_checker_view.dart';
import 'package:outcode_package/functionalities/oc_bug_reporter/oc_bug_reporter_wrapper_screen.dart';

import 'app_theme/app_theme_manager.dart';
import 'features/authentication/account/login/login_screen.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/device_management/bloc/device_management_bloc.dart';
import 'features/others/about_app_screen/app_information_view/bloc/app_version_info_view_bloc.dart';
import 'features/splash_screen.dart';
import 'flavor_config.dart';
import 'injector/injector.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;
  final GlobalKey<AppSwitcherProtectionState> _appSwitcherProtectionViewKey =
      GlobalKey();
  late final AuthenticationBloc _bloc;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _bloc = Injector.instance<AuthenticationBloc>();
    _setUpTheme();
    super.initState();
  }

  Future<void> _setUpTheme() async {
    AppThemeManager().onThemeChange = () {
      setState(() {});
    };
    await AppThemeManager().setInitialTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(
          value: _bloc,
        ),
        BlocProvider<DeviceManagementBloc>.value(
            value: Injector.instance<DeviceManagementBloc>()),
        BlocProvider<AppVersionInfoViewBloc>.value(
            value: Injector.instance<AppVersionInfoViewBloc>()),
      ],
      child: MaterialApp(
          theme: AppTheme().getCurrentTheme(context),
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            return AppSwitcherProtection(
              key: _appSwitcherProtectionViewKey,
              usesBiometricAuthentication: false,
              maxNotMatchCountLimit: 3,
              switcherWidget: Column(
                children: [
                  Image.asset(
                    FlavorConfig.appIconImage(),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Outcode Suite',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              hasAppShield: true,
              evictLoggedInUser: () {
                //handle
              },
              child: OCBugReporterWapperScreen(
                navigatorKey: _navigatorKey,
                listId: FlavorConfig.clickUpListId(),
                apiKey: FlavorConfig.clickUpApiKey(),
                imageString: FlavorConfig.appIconImage(),
                isVisible: !FlavorConfig.isProduction(),
                child: AppVersionCheckerView(
                  textColor: context.colorScheme.onPrimary,
                  child: BlocListener<AuthenticationBloc, AuthenticationState>(
                    bloc: _bloc,
                    listener: (context, state) {
                      if (state is AuthenticationAuthenticatedState) {
                        _navigator?.pushAndRemoveUntil(
                            DashboardScreen.route(), (route) => false);
                      } else if (state is AuthenticationUnauthenticatedState) {
                        _navigator?.pushAndRemoveUntil(
                            LoginScreen.route(), (route) => false);
                      } else if (state is AuthenticationTokenExistState) {
                        _navigator?.pushAndRemoveUntil(
                            DashboardScreen.route(), (route) => false);
                      }
                    },
                    child: child!,
                  ),
                ),
              ),
            );
          },
          onGenerateRoute: (settings) {
            _bloc.add(AuthenticationCheckUserSessionEvent());
            return SplashPage.route();
          }),
    );
  }
}
