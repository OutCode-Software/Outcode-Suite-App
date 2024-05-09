part of 'firebase_dynamic_link_handler_bloc.dart';

@immutable
abstract class FirebaseDynamicLinkHandlerEvent {}

class DynamicLinkReceivedEvent extends FirebaseDynamicLinkHandlerEvent {
  final Uri linkUrl;
  DynamicLinkReceivedEvent(this.linkUrl);
}

class ActivateAnyPendingDynamicLinkEvent
    extends FirebaseDynamicLinkHandlerEvent {
  ActivateAnyPendingDynamicLinkEvent();
}
