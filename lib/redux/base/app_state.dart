import 'package:equatable/equatable.dart';
import 'package:mc_login/redux/login/login_state.dart';

class AppState extends Equatable {
  LoginState loginState;

  AppState({this.loginState});

  factory AppState.initial() {
    return AppState(loginState: LoginState.initial());
  }

  AppState copyWith(LoginState loginState) {
    return AppState(loginState: loginState ?? this.loginState);
  }
}