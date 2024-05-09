part of 'device_management_bloc.dart';

@immutable
abstract class DeviceManagementEvent {}

class SetFCMTokenEvent extends DeviceManagementEvent {
  SetFCMTokenEvent();
}

class RegisterDeviceEvent extends DeviceManagementEvent {
  RegisterDeviceEvent();
}

class UpdateDeviceEvent extends DeviceManagementEvent {
  UpdateDeviceEvent();
}

class PushNotificationReceivedEvent extends DeviceManagementEvent {
  PushNotificationReceivedEvent();
}

class SendPushNotificationEvent extends DeviceManagementEvent {
  SendPushNotificationEvent(
      {required this.ids,
      required this.title,
      required this.body,
      this.payload});
  final List<String> ids;
  final String title;
  final String body;
  final Map<String, dynamic>? payload;
}
