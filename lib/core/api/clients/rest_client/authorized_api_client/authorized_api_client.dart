import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../models/device_data/device_data.dart';
import '../../../models/empty_success_response/empty_success_response.dart';
import '../../../models/user_data_wrapper/user_data_wrapper.dart';

part 'authorized_api_client.g.dart';

@RestApi()
abstract class AuthorizedApiClient {
  factory AuthorizedApiClient(Dio dio, {String baseUrl}) = _AuthorizedApiClient;

  @GET('auth/user')
  Future<UserDataWrapper> fetchUserDetail();

  @GET('users/{id}')
  Future<UserDataWrapper> fetchProfileInformation(@Path('id') String id);

  @POST('devices')
  Future<DeviceData> registerDevice(
    @Field() String name,
    @Field() String platform,
    @Field() String? pushToken,
    @Field() String versionName,
    @Field() int buildNumber,
  );

  @PATCH('devices/{id}')
  Future<EmptySuccessResponse> updateDevice(
    @Path('id') String deviceId,
    @Field('deviceName') String name,
    @Field() String versionName,
    @Field() int buildNumber,
  );

  @PUT('devices/{id}/push-token')
  Future<EmptySuccessResponse> setFCMToken(
    @Path('id') String deviceId,
    @Field('pushToken') String fcmToken,
  );

  @DELETE('devices/{id}')
  Future<EmptySuccessResponse> deleteDevice(
    @Path('id') String deviceId,
  );
}
