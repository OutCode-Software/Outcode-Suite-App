abstract class AnalyticsService {
  void identifyUser(String userId);

  void setAttribute(String key, dynamic value);

  void trackEvent(String eventName, {Map<String, dynamic>? properties});

  void clearIdentity();
}
