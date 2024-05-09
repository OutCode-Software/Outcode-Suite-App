import '../../domain/repositories/push_notification_repository.dart';
import '../data_sources/push_notification_data_sources/push_notification_remote_data_source.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  PushNotificationRepositoryImpl({
    required PushNotificationRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;
  final PushNotificationRemoteDataSource _remoteDataSource;

  @override
  Future<void> sendNotification(
      {required List<String> ids,
      required String title,
      required String body,
      Map<String, dynamic>? payload}) {
    return _remoteDataSource.sendNotification(
        ids: ids, title: title, body: body, payload: payload);
  }
}
