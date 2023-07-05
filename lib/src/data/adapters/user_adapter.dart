import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/src/models/user_model.dart';

class UserAdapter {
  static UserModel fromFirebaseUser(User user) {
    return UserModel(
      userID: user.uid,
      email: user.email,
      name: user.displayName,
      profilePictureURL: user.photoURL,
    );
  }
}
