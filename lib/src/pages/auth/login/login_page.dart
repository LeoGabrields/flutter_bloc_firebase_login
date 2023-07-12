import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/core/ui/helpers/messages.dart';
import 'package:login_firebase/src/core/ui/styles/text_styles.dart';
import 'package:login_firebase/src/pages/auth/login/login_bloc.dart';
import 'package:login_firebase/src/pages/auth/login/login_state.dart';
import 'package:login_firebase/src/pages/home/home_page.dart';
import 'package:validatorless/validatorless.dart';

import '../auth_bloc.dart';
import '../auth_event.dart';
import 'login_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Messages {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  var isObscure = true;

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.success) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                } else if (state.status == LoginStatus.error) {
                  showError(state.errorMessage ?? 'Error desconhecido');
                }
              },
              builder: (context, state) {
                final isLoading = state.status == LoginStatus.loading;
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Text('Login', style: context.textStyles.textTitle),
                    Text('Faça seu login para continuar',
                        style: context.textStyles.textRegular),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailEC,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                              validator: Validatorless.multiple([
                                Validatorless.email('Email inválido.'),
                                Validatorless.required(
                                    'Este campo é obrigatório.')
                              ]),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller: _passwordEC,
                                obscureText: isObscure,
                                decoration: InputDecoration(
                                  label: const Text('Senha'),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                      'Este campo é obrigatório.'),
                                  Validatorless.min(6,
                                      'A senha deve ter no mínimo 6 caracters.'),
                                ])),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final valid =
                                  _formKey.currentState?.validate() ?? false;
                              if (valid) {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(LoginRequest(
                                  email: _emailEC.text,
                                  password: _passwordEC.text,
                                ));
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Entrar'),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Ou',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(LoginGoogleRequest());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/icons_google.png'),
                          const SizedBox(width: 5),
                          const Text(
                            'Continue com Google',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta?',
                          style: context.textStyles.textRegular.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed('/register'),
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
