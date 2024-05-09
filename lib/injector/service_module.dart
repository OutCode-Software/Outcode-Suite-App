import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../services/analytics_service/analytics_service.dart';
import '../services/analytics_service/mixpanel_analytics_service.dart';
import '../services/api_log_service.dart';
import '../services/crashlytics_service/crashlytics_service.dart';
import '../services/crashlytics_service/firebase_crashlytics_service.dart';
import '../services/device_information_retrieval_service/device_information_retrieval_service.dart';
import '../services/device_information_retrieval_service/device_information_retrieval_service_impl.dart';
import '../services/firebase_dynamic_link_service/firebase_dynamic_link_service.dart';
import '../services/local_storage_service/local_storage_service.dart';
import '../services/local_storage_service/secured_storage_service.dart';
import '../services/log_service/debug_log_service.dart';
import '../services/log_service/log_service.dart';
import '../services/push_notification_service/push_notification_service.dart';
import '../services/share_service.dart';
import 'injector.dart';

class ServiceModule {
  ServiceModule._();

  static Future<void> init() async {
    final injector = Injector.instance;
    injector
      ..registerSingleton<ApiLogService>(ApiLogService())
      ..registerSingleton<CrashlyticsService>(FirebaseCrashlyticsService())
      ..registerSingletonAsync<PushNotificationService>(() async {
        final pushNotificationService =
            PushNotificationService(crashlyticsService: injector());
        return pushNotificationService;
      })
      ..registerFactory<LogService>(DebugLogService.new)
      ..registerSingletonAsync<LocalStorageService>(() async {
        final LocalStorageService service = SecuredStorageService();
        return service;
      })
      ..registerSingleton<ImagePicker>(ImagePicker())
      ..registerSingleton<ShareService>(ShareService())
      ..registerSingletonAsync<FirebaseDynamicLinkService>(() async {
        final firebaseDynamicLinkService = FirebaseDynamicLinkService();
        return firebaseDynamicLinkService;
      })
      ..registerSingleton<AnalyticsService>(MixpanelAnalyticsService())
      ..registerSingletonAsync<DeviceInformationRetrievalService>(() async {
        final DeviceInformationRetrievalService service =
            DeviceInformationRetrievalServiceImpl(
                deviceInfoPlugin: DeviceInfoPlugin(),
                packageInfo: await PackageInfo.fromPlatform());
        return service;
      });
  }
}
