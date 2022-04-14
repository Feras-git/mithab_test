//TODO: ImagePicker IOS Configuration
//TODO: Gallarey saver NSPhotoLibraryUsageDescription IOS permission
//TODO confirm firebase working with release (SHA)
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mithab_test/logic/authentication/authentication_bloc.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';
import 'package:mithab_test/screens/home_screen.dart';
import 'package:mithab_test/screens/login_screen.dart';
import 'package:sizer/sizer.dart';

import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthenticationRepository>(
              create: (context) => AuthenticationRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => AuthenticationBloc(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                )..add(AppStarted()),
              ),
            ],
            child: MyApp(),
          ),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mithab Test',
          builder: EasyLoading.init(),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  return HomeScreen();

                case AuthenticationStatus.unauthenticated:
                  return LoginScreen();

                default:
                  return HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
