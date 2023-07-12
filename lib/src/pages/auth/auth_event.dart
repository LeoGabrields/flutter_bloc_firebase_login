import '../../models/user_model.dart';

sealed class AuthEvent {}

class LogoutRequest implements AuthEvent {}

class UserChanged implements AuthEvent {
  final UserModel user;

  const UserChanged(this.user);
}
