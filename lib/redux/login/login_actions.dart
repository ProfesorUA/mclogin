import 'package:firebase_auth/firebase_auth.dart';

class Login {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class ShowResult {
  final FirebaseUser user;

  ShowResult(this.user);
}

class ShowError {
  final Object error;

  ShowError(this.error);
}

class ResetState { }