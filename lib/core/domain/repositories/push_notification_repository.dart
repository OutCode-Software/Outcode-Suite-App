abstract class PushNotificationRepository {
  Future<void> sendNotification(
      {required List<String> ids,
      required String title,
      required String body,
      Map<String, dynamic>? payload});
}
