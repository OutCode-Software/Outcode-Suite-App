import '../../flavor_config.dart';
import 'analytics_service.dart';

class MixpanelAnalyticsService extends AnalyticsService {
  MixpanelAnalyticsService() {
    init();
  }
  bool useAnalytics = false;

  Future<void> init() async {
    useAnalytics = FlavorConfig.useAnalytics();
    if (useAnalytics) {}
  }

  @override
  void identifyUser(String userId) {
    if (useAnalytics) {
      setAttribute('userId', userId);
    }
  }

  @override
  void setAttribute(String key, value) {
    if (useAnalytics) {}
  }

  @override
  void trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    if (useAnalytics) {}
  }

  @override
  void clearIdentity() {
    if (useAnalytics) {}
  }
}
