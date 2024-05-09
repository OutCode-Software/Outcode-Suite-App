import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../base/utils/utilities.dart';
import '../../../../../core/domain/domain_models/app_info_domain.dart';
import '../../../../../core/domain/repositories/device_repository.dart';
import '../../../../../services/device_information_retrieval_service/device_information.dart';
import '../../../../../services/device_information_retrieval_service/device_information_retrieval_service.dart';

part 'app_version_info_view_event.dart';
part 'app_version_info_view_state.dart';

class AppVersionInfoViewBloc
    extends Bloc<AppVersionInfoViewEvent, AppVersionInfoViewState> {
  AppVersionInfoViewBloc(
      {required DeviceInformationRetrievalService
          deviceInformationRetrievalService,
      required DeviceRepository deviceRepository})
      : _deviceInformationRetrievalService = deviceInformationRetrievalService,
        _deviceRepository = deviceRepository,
        super(AppVersionInfoViewIdleState()) {
    on<FetchAppInformationEvent>(_onFetchAppInformation);
  }

  final DeviceInformationRetrievalService _deviceInformationRetrievalService;
  final DeviceRepository _deviceRepository;

  _onFetchAppInformation(FetchAppInformationEvent event,
      Emitter<AppVersionInfoViewState> emit) async {
    final deviceInformation =
        await _deviceInformationRetrievalService.fetchDeviceInformation();
    final appInformation = await _deviceRepository.getAppInformation();
    appInformation.when(success: (appInfo) {
      var updateAvailable = false;
      if (deviceInformation.platform == 'android') {
        updateAvailable = Utilities.hasAppUpdate(
            existingVersion: deviceInformation.versionName,
            remoteVersion: appInfo.androidVersion);
      } else {
        updateAvailable = Utilities.hasAppUpdate(
            existingVersion: deviceInformation.versionName,
            remoteVersion: appInfo.iosVersion);
      }

      emit(FetchedAppInformationState(
          appInformation: AppInfoDomain(
              DeviceInformation(
                  name: '',
                  platform: '',
                  versionName: deviceInformation.versionName,
                  buildNumber: deviceInformation.buildNumber,
                  link: deviceInformation.platform == 'android'
                      ? appInfo.androidLink
                      : appInfo.iosLink),
              updateAvailable,
              true)));
    }, error: (error) {
      Utilities.printObj(error.toMessage());
    });
  }
}
