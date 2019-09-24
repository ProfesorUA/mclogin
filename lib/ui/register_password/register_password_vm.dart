
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/register/register_actions.dart';
import 'package:redux/redux.dart';

@immutable
class RegisterPasswordViewModel extends Equatable {
  final bool isDefault;
  final User user;
  final Object error;
  final Function() resetState;
  final Function(String email, String password) register;

  RegisterPasswordViewModel({
    this.isDefault,
    this.user,
    this.error,
    this.resetState,
    this.register,
  }) : super([
    isDefault,
    user,
  ]);

  static RegisterPasswordViewModel fromStore(Store<AppState> store) {
    return RegisterPasswordViewModel(
      isDefault: store.state.registerState.isDefault(),
      user: store.state.registerState.user,
      error: store.state.registerState.error,
      resetState: () => store.dispatch(ResetState()),
      register: (email, password) => store.dispatch(Register(email: email, password: password)),
    );
  }
}