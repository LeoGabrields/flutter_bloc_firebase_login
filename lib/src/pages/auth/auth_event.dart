// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/user_model.dart';

sealed class AuthEvent {}

class LogoutRequest implements AuthEvent {}

class UserChanged implements AuthEvent {
  final UserModel user;

  const UserChanged(this.user);
}

class LoginRequest implements AuthEvent {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest implements AuthEvent {
  final String email;
  final String password;
  RegisterRequest({
    required this.email,
    required this.password,
  });
}

class LoginGoogleRequest implements AuthEvent {}
