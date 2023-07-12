abstract class RegisterEvent {}

class RegisterRequest implements RegisterEvent {
  final String email;
  final String password;
  RegisterRequest({
    required this.email,
    required this.password,
  });
}
