part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationStatusChangeEvent extends AuthenticationEvent {
  final bool status;
  AuthenticationStatusChangeEvent(this.status);
}

class AuthenticationCheckUserSessionEvent extends AuthenticationEvent {
  AuthenticationCheckUserSessionEvent();
}

class FetchUserInfoEvent extends AuthenticationEvent {
  FetchUserInfoEvent();
}
