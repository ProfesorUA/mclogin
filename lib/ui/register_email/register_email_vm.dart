
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:redux/redux.dart';

@immutable
class RegisterEmailViewModel extends Equatable {
  final bool isDefault;
  final Function() resetState;

  RegisterEmailViewModel({
    this.isDefault,
    this.resetState,
  }) : super([
    isDefault,
  ]);

  static RegisterEmailViewModel fromStore(Store<AppState> store) {
    return RegisterEmailViewModel(
      isDefault: store.state.loginState.isDefault(),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}