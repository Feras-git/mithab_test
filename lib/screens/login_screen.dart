import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mithab_test/common/enums.dart';
import 'package:mithab_test/logic/login/login_cubit.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';
import 'package:mithab_test/screens/home_screen.dart';
import 'package:mithab_test/utils/app_dialogs.dart';

import 'package:sizer/sizer.dart';

import 'package:mithab_test/common/constants.dart';
import 'package:mithab_test/helpers/validator.dart';
import 'package:mithab_test/logic/authentication/authentication_bloc.dart';
import 'package:mithab_test/screens/signup_screen.dart';
import 'package:mithab_test/widgets/custom_button.dart';
import 'package:mithab_test/widgets/entry_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(
        authenticationBloc: context.read<AuthenticationBloc>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == StateStatus.loading) {
                AppDialogs.showLoading();
              } else {
                AppDialogs.dismissLoading();
                if (state.status == StateStatus.failure) {
                  AppDialogs.showCustomAlert(
                      context: context,
                      title: 'Something wrong!',
                      content: state.errorMessage);
                } else if (state.status == StateStatus.successful) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: kMainColor,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('MITHAB TEST'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      children: [
                        EntryField(
                          icon: Icons.email,
                          hintText: 'Email',
                          onChanged: (value) {
                            context.read<LoginCubit>().emailChanged(value);
                          },
                          errorText:
                              state.email.isEmpty || isEmailValid(state.email)
                                  ? null
                                  : 'Email should be like email@example.com',
                        ),
                        SizedBox(height: 2.h),
                        EntryField(
                          icon: Icons.password,
                          hintText: 'Password',
                          obscureText: true,
                          onChanged: (value) {
                            context.read<LoginCubit>().passwordChanged(value);
                          },
                          errorText: state.password.isEmpty ||
                                  isPasswordValid(state.password)
                              ? null
                              : 'Password should be 6 characters minimum',
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 80.w,
                              child: CustomButton(
                                text: 'Login',
                                icon: Icons.login,
                                onPressed: () async {
                                  if (isEmailValid(state.email) &&
                                      isPasswordValid(state.password)) {
                                    await context.read<LoginCubit>().login();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?    '),
                              GestureDetector(
                                child: Text(
                                  'Sign up here',
                                  style: TextStyle(
                                    color: kMainColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
