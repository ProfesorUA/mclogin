import 'package:equatable/equatable.dart';
import 'package:mc_login/redux/login/login_state.dart';
import 'package:mc_login/redux/main/main_state.dart';
import 'package:mc_login/redux/register/register_state.dart';

class AppState extends Equatable {
  LoginState loginState;
  RegisterState registerState;
  MainState mainState;

  AppState({this.loginState, this.registerState, this.mainState});

  factory AppState.initial() {
    return AppState(
        loginState: LoginState.initial(),
        registerState: RegisterState.initial(),
        mainState: MainState.initial());
  }

  AppState copyWith(
      LoginState loginState, RegisterState registerState, MainState mainState) {
    return AppState(
        loginState: loginState ?? this.loginState,
        registerState: registerState ?? this.registerState,
        mainState: mainState ?? this.mainState);
  }
}
