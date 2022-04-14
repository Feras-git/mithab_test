part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = StateStatus.initial,
    this.errorMessage = '',
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String errorMessage;
  final StateStatus status;

  @override
  List<Object> get props {
    return [
      email,
      password,
      confirmPassword,
      errorMessage,
      status,
    ];
  }

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? errorMessage,
    StateStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
