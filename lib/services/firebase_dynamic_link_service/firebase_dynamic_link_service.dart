import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../features/firebase_dynamic_link_handler/bloc/firebase_dynamic_link_handler_bloc.dart';
import '../../injector/injector.dart';
import '../crashlytics_service/crashlytics_service.dart';

class FirebaseDynamicLinkService {
  FirebaseDynamicLinkService() {
    init();
  }
  Uri? _pendingLink;

  Future<void> init() async {
    FirebaseDynamicLinks.instance.onLink
        .listen(_onNewDynamicDeeplinkDataReceived)
        .onError((error) {
      Injector.instance<CrashlyticsService>().recordError(
        error,
        null,
      );
    });
  }

  void _onNewDynamicDeeplinkDataReceived(PendingDynamicLinkData data) {
    Injector.instance<FirebaseDynamicLinkBloc>()
        .add(DynamicLinkReceivedEvent(data.link));
  }

  Future<void> checkForNewDynamicDeeplink() async {
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      _onNewDynamicDeeplinkDataReceived(initialLink);
    }
  }

  void cachePendingLinkUntilLogin(Uri? invitationLink) {
    _pendingLink = invitationLink;
  }

  void removePendingDeepLink() {
    _pendingLink = null;
  }

  void initiateAnyPendingDeeplink() {
    if (_pendingLink != null) {
      Injector.instance<FirebaseDynamicLinkBloc>()
          .add(DynamicLinkReceivedEvent(_pendingLink!));
    }
  }
}
