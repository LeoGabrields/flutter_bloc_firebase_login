import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userID;
  final String? email;
  final String? name;
  final String? profilePictureURL;

  const UserModel({
    required this.userID,
    this.email,
    this.name,
    this.profilePictureURL,
  });

  static const empty = UserModel(userID: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [userID, email, name, profilePictureURL];
}
