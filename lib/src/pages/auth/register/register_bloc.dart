import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/src/pages/auth/register/register_event.dart';
import 'package:login_firebase/src/pages/auth/register/register_state.dart';

import '../../../data/services/firebase_auth_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthService firebaseAuthService;

  RegisterBloc({required this.firebaseAuthService})
      : super(const RegisterState.initial()) {
    on<RegisterRequest>(_onRegisterRequest);
  }

  Future<void> _onRegisterRequest(
    RegisterRequest event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final newState = await firebaseAuthService.createUserWithEmailAndPassoword(
        event.email, event.password);
    emit(newState);
  }
}
