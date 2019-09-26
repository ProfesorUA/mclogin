import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/main/main_actions.dart';
import 'package:redux/redux.dart';

@immutable
class MainViewModel extends Equatable {
  final bool isLoading;
  final bool shouldCloseScreen;
  final bool isDefault;
  final Function() resetState;
  final Function() logout;
  final Object error;

  MainViewModel(
      {this.isDefault,
      this.resetState,
      this.isLoading,
      this.shouldCloseScreen,
      this.logout,
      this.error})
      : super([
          isDefault,
          isLoading,
          shouldCloseScreen,
          error,
        ]);

  static MainViewModel fromStore(Store<AppState> store) {
    return MainViewModel(
      isDefault: store.state.mainState.isDefault(),
      resetState: () => store.dispatch(ResetState()),
      isLoading: store.state.mainState.isLoading,
      shouldCloseScreen: store.state.mainState.shouldCloseScreen,
      error: store.state.mainState.error,
      logout: () => store.dispatch(Logout()),
    );
  }
}
