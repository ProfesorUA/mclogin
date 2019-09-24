import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:redux/redux.dart';

@immutable
class RegisterEmailViewModel extends Equatable {
  final Function() resetState;

  RegisterEmailViewModel({
    this.resetState,
  }) : super([]);

  static RegisterEmailViewModel fromStore(Store<AppState> store) {
    return RegisterEmailViewModel(
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
