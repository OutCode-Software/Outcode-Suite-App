import '../features/authentication/bloc/authentication_bloc.dart';
import '../features/device_management/bloc/device_management_bloc.dart';
import '../features/firebase_dynamic_link_handler/bloc/firebase_dynamic_link_handler_bloc.dart';
import '../features/others/about_app_screen/app_information_view/bloc/app_version_info_view_bloc.dart';
import 'injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(
        authenticationRepository: injector(), userRepository: injector()));

    _initializeTertiaryBloc();
  }

  static void _initializeTertiaryBloc() {
    final injector = Injector.instance;
    injector
      ..registerLazySingleton<DeviceManagementBloc>(() {
        final bloc = DeviceManagementBloc(
            deviceRepository: injector(),
            pushNotificationService: injector(),
            deviceInformationRetrievalService: injector(),
            userRepository: injector(),
            pushNotificationRepository: injector());
        return bloc;
      })
      ..registerLazySingleton<FirebaseDynamicLinkBloc>(() {
        final bloc = FirebaseDynamicLinkBloc(
          userRepository: injector(),
          firebaseDynamicLinkService: injector(),
        );
        return bloc;
      })
      ..registerLazySingleton<AppVersionInfoViewBloc>(() {
        final bloc = AppVersionInfoViewBloc(
            deviceInformationRetrievalService: injector(),
            deviceRepository: injector());
        return bloc;
      });
  }
}
