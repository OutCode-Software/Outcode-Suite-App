import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/entities/user_entity/user_entity.dart';
import '../../../core/domain/repositories/user_repository.dart';
import '../../../services/firebase_dynamic_link_service/firebase_dynamic_link_service.dart';

part 'firebase_dynamic_link_handler_event.dart';
part 'firebase_dynamic_link_handler_state.dart';

class FirebaseDynamicLinkBloc extends Bloc<FirebaseDynamicLinkHandlerEvent,
    FirebaseDynamicLinkHandlerState> {
  FirebaseDynamicLinkBloc(
      {required UserRepository userRepository,
      required FirebaseDynamicLinkService firebaseDynamicLinkService})
      : _userRepository = userRepository,
        _firebaseDynamicLinkService = firebaseDynamicLinkService,
        super(FirebaseDynamicLinkHandlerIdleState()) {
    on<DynamicLinkReceivedEvent>(_onNewDynamicLinkReceived);
    on<ActivateAnyPendingDynamicLinkEvent>(
        _onActivateAnyPendingDynamicLinkEvent);
  }

  final FirebaseDynamicLinkService _firebaseDynamicLinkService;
  final UserRepository _userRepository;

  String? getGoalTeamInviteLinkId(Uri link) {
    final queryParams = link.queryParameters;
    return queryParams['..'];
  }

  Future<UserEntity?> getCurrentUser(Uri link) async {
    final userReponse = await _userRepository.getCurrentUserFromCache();
    if (userReponse == null) {
      _firebaseDynamicLinkService.cachePendingLinkUntilLogin(link);
    }

    return userReponse;
  }

  Future<void> _onNewDynamicLinkReceived(DynamicLinkReceivedEvent event,
      Emitter<FirebaseDynamicLinkHandlerState> emit) async {
    final _ = event.linkUrl;
  }

  Future<void> _onActivateAnyPendingDynamicLinkEvent(
      ActivateAnyPendingDynamicLinkEvent event,
      Emitter<FirebaseDynamicLinkHandlerState> emit) async {
    _firebaseDynamicLinkService.initiateAnyPendingDeeplink();
  }
}
