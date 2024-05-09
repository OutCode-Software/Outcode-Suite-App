import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/utils/utilities.dart';
import '../../../core/domain/repositories/device_repository.dart';
import '../../../core/domain/repositories/push_notification_repository.dart';
import '../../../core/domain/repositories/user_repository.dart';
import '../../../injector/injector.dart';
import '../../../services/device_information_retrieval_service/device_information_retrieval_service.dart';
import '../../../services/push_notification_service/push_notification_service.dart';

part 'device_management_event.dart';
part 'device_management_state.dart';

class DeviceManagementBloc
    extends Bloc<DeviceManagementEvent, DeviceManagementState> {
  DeviceManagementBloc({
    required DeviceRepository deviceRepository,
    required UserRepository userRepository,
    required PushNotificationRepository pushNotificationRepository,
    required DeviceInformationRetrievalService
        deviceInformationRetrievalService,
    required PushNotificationService pushNotificationService,
  })  : _deviceRepository = deviceRepository,
        _userRepository = userRepository,
        _pushNotificationRepository = pushNotificationRepository,
        _deviceInformationRetrievalService = deviceInformationRetrievalService,
        _pushNotificationService = pushNotificationService,
        super(PushNotificationIdleState()) {
    on<SetFCMTokenEvent>(_onSetPushNotificationToken);
    on<RegisterDeviceEvent>(_onRegisterDevice);
    on<UpdateDeviceEvent>(_onUpdateDevice);
    on<PushNotificationReceivedEvent>(_onPushNotificationReceived);
    on<SendPushNotificationEvent>(_onSendPushNotification);
  }

  final UserRepository _userRepository;
  final DeviceRepository _deviceRepository;
  final PushNotificationRepository _pushNotificationRepository;
  final PushNotificationService _pushNotificationService;
  final DeviceInformationRetrievalService _deviceInformationRetrievalService;

  Future<void> _onSetPushNotificationToken(
      SetFCMTokenEvent event, Emitter<DeviceManagementState> emit) async {
    final pushToken = await _pushNotificationService.getPushToken();
    final userId = await _userRepository.getCurrentUserId();
    if (pushToken == null || userId == null) {
      return;
    }
    final response = await _deviceRepository.setFCMToken(
        userId: userId, fcmToken: pushToken);
    response.when(
        success: (_) {},
        error: (error) {
          Utilities.printObj(error.toMessage());
        });
  }

  Future<void> _onRegisterDevice(
      RegisterDeviceEvent event, Emitter<DeviceManagementState> emit) async {
    final info =
        await _deviceInformationRetrievalService.fetchDeviceInformation();

    final pushToken = await _pushNotificationService.getPushToken();
    final userId = await _userRepository.getCurrentUserId();
    if (userId == null) {
      return;
    }
    final response = await _deviceRepository.registerDevice(
        userId: userId,
        name: info.name,
        platform: info.platform,
        versionName: info.versionName,
        buildNumber: info.buildNumber,
        pushToken: pushToken);
    response.when(success: (_) {
      Injector.instance<DeviceManagementBloc>().add(SetFCMTokenEvent());
    }, error: (error) {
      Utilities.printObj(error.toMessage());
    });
  }

  Future<void> _onUpdateDevice(
      UpdateDeviceEvent event, Emitter<DeviceManagementState> emit) async {
    final info =
        await _deviceInformationRetrievalService.fetchDeviceInformation();
    final userId = await _userRepository.getCurrentUserId();
    if (userId == null) {
      return;
    }
    final response = await _deviceRepository.updateDevice(
        userId: userId,
        name: info.name,
        versionName: info.versionName,
        buildNumber: info.buildNumber);
    response.when(success: (_) {
      Utilities.printObj('Device updated');
    }, error: (error) {
      Utilities.printObj(error.toMessage());
    });
  }

  Future<void> _onPushNotificationReceived(PushNotificationReceivedEvent event,
      Emitter<DeviceManagementState> emit) async {}

  Future<void> _onSendPushNotification(SendPushNotificationEvent event,
      Emitter<DeviceManagementState> emit) async {
    await _pushNotificationRepository.sendNotification(
        ids: event.ids,
        title: event.title,
        body: event.body,
        payload: event.payload);
  }
}
