import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login_firebase/src/data/services/firebase_auth_service.dart';

import '../../models/user_model.dart';
import 'auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService firebaseAuthService;
  StreamSubscription<UserModel>? userSubscription;

  AuthBloc({required this.firebaseAuthService})
      : super(const AuthState.initial()) {
    on<UserChanged>(_onUserChanged);
    on<LogoutRequest>(_onLogoutRequest);
    on<LoginRequest>(_onLoginRequest);
    on<LoginGoogleRequest>(_signInWithGoogle);
    on<RegisterRequest>(_onRegisterRequest);

    userSubscription = firebaseAuthService.user.listen((user) {
      add(UserChanged(user));
    });
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(event.user.isEmpty
        ? state.copyWith(status: AuthStatus.unauthenticated)
        : state.copyWith(status: AuthStatus.authenticated, user: event.user));
  }

  void _onLogoutRequest(
    LogoutRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final newState = await firebaseAuthService.logout();
    emit(newState);
  }

  @override
  Future<void> close() {
    userSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoginRequest(
    LoginRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final newState = await firebaseAuthService.loginWithEmailAndPassword(
        event.email, event.password);
    emit(newState);
  }

  Future<void> _onRegisterRequest(
    RegisterRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final newState = await firebaseAuthService.createUserWithEmailAndPassoword(
        event.email, event.password);
    emit(newState);
  }

  Future<void> _signInWithGoogle(
    LoginGoogleRequest event,
    Emitter<AuthState> emit,
  ) async {
    final newState = await firebaseAuthService.logInWithGoogle();
    emit(newState);
  }
}
