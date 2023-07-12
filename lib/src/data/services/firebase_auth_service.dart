import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/src/data/adapters/user_adapter.dart';
import 'package:login_firebase/src/pages/auth/auth_state.dart';
import 'package:login_firebase/src/models/user_model.dart';
import 'package:login_firebase/src/pages/auth/login/login_state.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null
          ? UserModel.empty
          : UserAdapter.fromFirebaseUser(firebaseUser);
      return user;
    });
  }

  Future<LoginState> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        // final user = UserAdapter.fromFirebaseUser(result.user!);
        return const LoginState(status: LoginStatus.success);
      } else {
        return const LoginState(status: LoginStatus.error);
      }
    } on FirebaseAuthException catch (e) {
      var errorMessage = '';
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Email inválido';
        case 'user-disabled':
          errorMessage = 'Usuário desabilitado';
        case 'user-not-found':
          errorMessage = 'Usuário não encontrado';
        case 'wrong-password':
          errorMessage = 'Senha incorreta';
      }
      return LoginState(status: LoginStatus.error, errorMessage: errorMessage);
    }
  }

  // Método que permita aos usuários criar uma conta
  Future<AuthState> createUserWithEmailAndPassoword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final user = UserAdapter.fromFirebaseUser(result.user!);
        return AuthState(status: AuthStatus.authenticated, user: user);
      } else {
        return const AuthState(status: AuthStatus.unauthenticated);
      }
    } on FirebaseAuthException catch (e) {
      var errorMessage = '';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email já em uso';
        case 'invalid-email':
          errorMessage = 'Email inválido';
        case 'operation-not-allowed':
          errorMessage = 'Operação não permitida';
        case 'weak-password':
          errorMessage = 'Senha fraca';
      }
      return AuthState(status: AuthStatus.error, errorMessage: errorMessage);
    }
  }

  // Método para que possamos oferecer aos usuários a opção de efetuar logout e limpar suas informações de perfil do dispositivo.
  Future<AuthState> logout() async {
    await _auth.signOut();
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  // Google Sign In
  Future<AuthState> logInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final result = await _auth.signInWithCredential(credential);
    if (result.user != null) {
      final user = UserAdapter.fromFirebaseUser(result.user!);
      return AuthState(status: AuthStatus.authenticated, user: user);
    } else {
      return const AuthState(status: AuthStatus.unauthenticated);
    }
  }
}
