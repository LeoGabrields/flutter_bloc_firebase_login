import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/pages/auth/auth_bloc.dart';
import 'package:login_firebase/src/pages/auth/auth_state.dart';
import 'package:login_firebase/src/pages/auth/login/login_bloc.dart';
import 'package:login_firebase/src/pages/auth/register/register_bloc.dart';
import 'package:login_firebase/src/pages/home/home_page.dart';

import 'data/services/firebase_auth_service.dart';
import 'pages/auth/login/login_page.dart';
import 'core/ui/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              firebaseAuthService: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              firebaseAuthService: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(
              firebaseAuthService: context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.theme,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
