import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mithab_test/common/constants.dart';
import 'package:mithab_test/common/enums.dart';
import 'package:mithab_test/helpers/validator.dart';
import 'package:mithab_test/logic/SignUp/signup_cubit.dart';
import 'package:mithab_test/logic/authentication/authentication_bloc.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';
import 'package:mithab_test/screens/home_screen.dart';
import 'package:mithab_test/utils/app_dialogs.dart';
import 'package:mithab_test/widgets/custom_button.dart';
import 'package:mithab_test/widgets/entry_field.dart';
import 'package:sizer/sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(
        authenticationBloc: context.read<AuthenticationBloc>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SignupCubit, SignupState>(
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
                      vertical: 9.h,
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
                  Text(
                    'Register new account',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: kMainColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
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
                            context.read<SignupCubit>().emailChanged(value);
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
                            context.read<SignupCubit>().passwordChanged(value);
                          },
                          errorText: state.password.isEmpty ||
                                  isPasswordValid(state.password)
                              ? null
                              : 'Password should be 6 characters minimum',
                        ),
                        SizedBox(height: 2.h),
                        EntryField(
                          icon: Icons.password,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          onChanged: (value) {
                            context
                                .read<SignupCubit>()
                                .confirmPasswordChanged(value);
                          },
                          errorText: state.confirmPassword.isEmpty ||
                                  state.password == state.confirmPassword
                              ? null
                              : 'Password not match!',
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 80.w,
                              child: CustomButton(
                                text: 'Register',
                                icon: Icons.app_registration,
                                onPressed: () async {
                                  if (isEmailValid(state.email) &&
                                      isPasswordValid(state.password) &&
                                      state.password == state.confirmPassword) {
                                    await context.read<SignupCubit>().signup();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?    '),
                              GestureDetector(
                                child: Text(
                                  'Back to login',
                                  style: TextStyle(
                                    color: kMainColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
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
