import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/repositories/auth_repository.dart';
import '../../../../core/domain/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthRepository authenticationRepository,
      required UserRepository userRepository})
      : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(AuthenticationIdleState()) {
    on<AuthenticationStatusChangeEvent>(_onAuthenticated);
    on<AuthenticationCheckUserSessionEvent>(_onRequestUserSession);
    on<FetchUserInfoEvent>(_onFetchUserInformation);
  }

  final AuthRepository _authenticationRepository;
  final UserRepository _userRepository;

  Future<void> _onRequestUserSession(AuthenticationCheckUserSessionEvent event,
      Emitter<AuthenticationState> emit) async {
    final result = await _authenticationRepository.fetchCachedToken();
    result.whenOrNull(
      success: (token) {
        emit(AuthenticationTokenExistState());
      },
      error: (_) {
        emit(AuthenticationUnauthenticatedState());
      },
    );
  }

  Future<void> _onAuthenticated(AuthenticationStatusChangeEvent event,
      Emitter<AuthenticationState> emit) async {
    if (event.status) {
      emit(AuthenticationAuthenticatedState());
    } else {
      emit(AuthenticationUnauthenticatedState());
    }
  }

  Future<void> _onFetchUserInformation(
    FetchUserInfoEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit.forEach(
        _userRepository.fetchUserDetails(
            fetchesFromLocalDB: true,
            fetchesFromRemote: false), onData: (data) {
      return data.maybeWhen(success: (userEntity) {
        return AuthenticationAuthenticatedState();
      }, orElse: () {
        _authenticationRepository.logout();
        return AuthenticationUnauthenticatedState();
      });
    });
  }
}
