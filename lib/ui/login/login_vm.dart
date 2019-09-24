
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:redux/redux.dart';

@immutable
class LoginViewModel extends Equatable {
  final bool loading;
//  final User user;
  final Object error;
  final Function(String, String) login;
  final bool isDefault;
//  final Function() resetState;

  LoginViewModel({
    this.loading,
//    this.user,
    this.error,
    this.login,
    this.isDefault,
//    this.resetState,
  }) : super([
    loading,
//    user,
    error,
    isDefault,
  ]);

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      loading: store.state.loginState.isLoading,
//      user: store.state.loginState.user,
      error: store.state.loginState.error,
      login: (phone, password) => store.dispatch(Login(phone, password)),
      isDefault: store.state.loginState.isDefault(),
//      resetState: () => store.dispatch(LpResetState()),
    );
  }
}