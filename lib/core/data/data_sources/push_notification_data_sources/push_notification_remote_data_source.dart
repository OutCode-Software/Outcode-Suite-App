import '../../../api/clients/rest_client/authorized_api_client/authorized_api_client.dart';

abstract class PushNotificationRemoteDataSource {
  Future<void> sendNotification(
      {required List<String> ids,
      required String title,
      required String body,
      Map<String, dynamic>? payload});
}

class PushNotificationRemoteDataSourceImpl
    implements PushNotificationRemoteDataSource {
  PushNotificationRemoteDataSourceImpl({required AuthorizedApiClient apiClient})
      : _apiClient = apiClient;

  final AuthorizedApiClient _apiClient;

  @override
  Future<void> sendNotification(
      {required List<String> ids,
      required String title,
      required String body,
      Map<String, dynamic>? payload}) {
    return Future.value();
  }
}
