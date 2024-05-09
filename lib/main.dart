import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:outcode_package/functionalities/remote_localization/firebase_localization/firebase_remote_localization_service.dart';

import 'config/http_overrides.dart';
import 'injector/injector.dart';
import 'main_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await initializeDateFormatting();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await FirebaseRemoteLocalizationService().initService();
  await Injector.init();
  await Injector.instance.allReady();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: FirebaseRemoteLocalizationService().getLocales(),
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: FirebaseRemoteLocalizationService().assetLoader,
        child: const MainApp()),
  );

  /* await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await initializeDateFormatting();
        HttpOverrides.global = MyHttpOverrides();

        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        await FirebaseRemoteLocalizationService().initService();
        await Injector.init();
        await Injector.instance.allReady();
        await EasyLocalization.ensureInitialized();

        /*final mapsImplementation = GoogleMapsFlutterPlatform.instance;
        if (mapsImplementation is GoogleMapsFlutterAndroid) {
          mapsImplementation.useAndroidViewSurface = true;
          await initializeMapRenderer();
        }*/

        runApp(
          EasyLocalization(
              supportedLocales:
                  FirebaseRemoteLocalizationService().getLocales(),
              path: 'assets/translations',
              fallbackLocale: const Locale('en', 'US'),
              assetLoader: FirebaseRemoteLocalizationService().assetLoader,
              child: const MainApp()),
        );
      },
      (error, stackTrace) {},
      zoneSpecification: ZoneSpecification(print: (self, parent, zone, line) {
        parent.print(zone, 'Intercepted: $line');
        // final stackTrace = StackTrace.current;
        // parent.print(zone, "Intercepted Stack trace: ${stackTrace.toString()}");
        ConsoleLogStream().updateData(line);
      }));*/
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
}
