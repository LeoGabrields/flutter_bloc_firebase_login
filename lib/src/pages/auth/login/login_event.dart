abstract class LoginEvent {}

class LoginRequest implements LoginEvent {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });
}

class LoginGoogleRequest implements LoginEvent {}
