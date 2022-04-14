part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationLogInRequested extends AuthenticationEvent {
  final User? user;

  AuthenticationLogInRequested({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthenticationSignUpRequested extends AuthenticationEvent {
  final User? user;

  AuthenticationSignUpRequested({this.user});

  @override
  List<Object?> get props => [user];
}

class AppStarted extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
