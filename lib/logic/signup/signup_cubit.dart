import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mithab_test/common/enums.dart';
import 'package:mithab_test/logic/authentication/authentication_bloc.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required this.authenticationRepository,
    required this.authenticationBloc,
  }) : super(SignupState());

  final AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  void emailChanged(String value) {
    emit(state.copyWith(email: value.trim()));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  Future signup() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await authenticationRepository.signUp(
          email: state.email, password: state.password);
      emit(state.copyWith(status: StateStatus.successful));
      authenticationBloc.add(AuthenticationSignUpRequested());
    } catch (error) {
      emit(state.copyWith(
        status: StateStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
