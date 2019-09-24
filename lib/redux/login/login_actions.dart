import 'package:mc_login/data/models/User.dart';

class Login {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class ShowResult {
  final User user;

  ShowResult(this.user);
}

class ShowError {
  final Object error;

  ShowError(this.error);
}

class ResetState { }