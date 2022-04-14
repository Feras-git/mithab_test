import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(const AuthenticationState.unknown());

  final AuthenticationRepository authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is AuthenticationLogInRequested) {
      yield* _mapAuthenticationLogInRequestedToState(user: event.user);
    }
    if (event is AuthenticationSignUpRequested) {
      yield* _mapAuthenticationSignUpRequestedToState(user: event.user);
    }
    if (event is AuthenticationLogoutRequested) {
      yield* _mapAuthenticationLogOutRequestedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final bool? isSignedIn = authenticationRepository.isSignIn();
      if (!isSignedIn!) {
        yield AuthenticationState.unauthenticated();
      } else {
        final User? currentUser = authenticationRepository.getCurrentUser();
        yield AuthenticationState.authenticated(currentUser);
      }
    } catch (error) {
      print('ERROR IN _mapAppStartedToState: $error');
      yield AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogInRequestedToState(
      {User? user}) async* {
    if (user != null) {
      yield AuthenticationState.authenticated(user);
    } else {
      yield AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationSignUpRequestedToState(
      {User? user}) async* {
    if (user != null) {
      yield AuthenticationState.authenticated(user);
    } else {
      yield AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState>
      _mapAuthenticationLogOutRequestedToState() async* {
    yield AuthenticationState.unauthenticated();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
