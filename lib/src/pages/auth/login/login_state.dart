import 'package:equatable/equatable.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({required this.status, this.errorMessage});

  const LoginState.initial()
      : status = LoginStatus.initial,
        errorMessage = null;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
