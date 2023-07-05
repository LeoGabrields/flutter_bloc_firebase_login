import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/pages/auth/auth_bloc.dart';
import 'package:login_firebase/src/pages/home/home_page.dart';

import 'data/services/firebase_auth_service.dart';
import 'pages/auth/login/login_page.dart';
import 'pages/auth/register/register_page.dart';
import 'core/ui/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          firebaseAuthService: context.read(),
        ),
        child: MaterialApp(
          initialRoute: '/login',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.theme,
          routes: {
            '/login': (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
            '/home': (_) => const HomePage(),
          },
        ),
      ),
    );
  }
}
