import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/pages/auth/auth_state.dart';

import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import '../auth/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(state.user?.name ?? ''),
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutRequest());
                },
                icon: const Icon(Icons.exit_to_app),
              )
            ],
          ),
          body: Center(
            child: Text(state.user?.email ?? ''),
          ),
        );
      },
    );
  }
}
