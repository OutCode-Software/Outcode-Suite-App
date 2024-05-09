import 'device_information.dart';

abstract class DeviceInformationRetrievalService {
  Future<DeviceInformation> fetchDeviceInformation();
}
