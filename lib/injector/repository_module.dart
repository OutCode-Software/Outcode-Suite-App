import '../core/data/repository_impl/auth_repository_impl.dart';
import '../core/data/repository_impl/device_repository_impl.dart';
import '../core/data/repository_impl/push_notification_repository_impl.dart';
import '../core/data/repository_impl/user_repository_impl.dart';
import '../core/domain/repositories/auth_repository.dart';
import '../core/domain/repositories/device_repository.dart';
import '../core/domain/repositories/push_notification_repository.dart';
import '../core/domain/repositories/user_repository.dart';
import 'injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    final injector = Injector.instance;

    injector
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
            remoteDataSource: injector(), localDataSource: injector()),
      )
      ..registerFactory<DeviceRepository>(
        () => DeviceRepositoryImpl(
            remoteDataSource: injector(), localDataSource: injector()),
      )
      ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(
            remoteDataSource: injector(), localDataSource: injector()),
      )
      ..registerFactory<PushNotificationRepository>(
        () => PushNotificationRepositoryImpl(remoteDataSource: injector()),
      );
  }
}
