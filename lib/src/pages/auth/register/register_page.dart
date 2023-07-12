import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/core/ui/helpers/messages.dart';
import 'package:login_firebase/src/core/ui/styles/text_styles.dart';
import 'package:validatorless/validatorless.dart';

import '../../home/home_page.dart';
import '../login/login_bloc.dart';
import '../login/login_event.dart';
import '../login/login_page.dart';
import 'register_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Messages {
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
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state.status == RegisterStatus.success) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                } else if (state.status == RegisterStatus.error) {
                  showError(state.errorMessage ?? '');
                }
              },
              builder: (context, state) {
                final isLoading = state.status == RegisterStatus.loading;
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Text('Cadastro', style: context.textStyles.textTitle),
                    Text('Faça seu cadastro para continuar',
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
                            const SizedBox(height: 10),
                            TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  label: const Text('Confirmar senha'),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.visibility),
                                  ),
                                ),
                                validator: Validatorless.multiple([
                                  Validatorless.compare(_passwordEC,
                                      'As duas senhas devem ser iguais.'),
                                  Validatorless.required(
                                      'A confirmação da senha é obrigatória.')
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
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(RegisterRequest(
                                  email: _emailEC.text,
                                  password: _passwordEC.text,
                                ));
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Cadastrar'),
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
                        BlocProvider.of<LoginBloc>(context)
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
                          'Ja tem uma conta?',
                          style: context.textStyles.textRegular.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          )),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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
