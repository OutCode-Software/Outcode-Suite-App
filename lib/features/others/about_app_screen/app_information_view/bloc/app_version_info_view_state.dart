part of 'app_version_info_view_bloc.dart';

abstract class AppVersionInfoViewState {}

class AppVersionInfoViewIdleState extends AppVersionInfoViewState {}

class FetchingAppInformationState extends AppVersionInfoViewState {}

class FetchedAppInformationState extends AppVersionInfoViewState {
  FetchedAppInformationState({required this.appInformation});
  final AppInfoDomain appInformation;
}
