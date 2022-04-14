import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mithab_test/common/enums.dart';
import 'package:mithab_test/logic/authentication/authentication_bloc.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authenticationRepository,
    required this.authenticationBloc,
  }) : super(LoginState());

  final AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  void emailChanged(String value) {
    emit(state.copyWith(email: value.trim()));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future login() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      await authenticationRepository.signIn(
          email: state.email, password: state.password);
      emit(state.copyWith(status: StateStatus.successful));
      authenticationBloc.add(AuthenticationLogInRequested());
    } catch (error) {
      emit(state.copyWith(
        status: StateStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
