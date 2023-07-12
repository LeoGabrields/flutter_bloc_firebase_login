import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/pages/auth/login/login_event.dart';
import 'package:login_firebase/src/pages/auth/login/login_state.dart';

import '../../../data/services/firebase_auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuthService firebaseAuthService;

  LoginBloc({required this.firebaseAuthService})
      : super(const LoginState.initial()) {
    on<LoginRequest>(_onLoginRequest);
    on<LoginGoogleRequest>(_signInWithGoogle);
  }

  Future<void> _onLoginRequest(
    LoginRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final newState = await firebaseAuthService.loginWithEmailAndPassword(
        event.email, event.password);
    emit(newState);
  }

  Future<void> _signInWithGoogle(
    LoginGoogleRequest event,
    Emitter<LoginState> emit,
  ) async {
    final newState = await firebaseAuthService.logInWithGoogle();
    emit(newState);
  }
}
