import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/main/main_actions.dart';
import 'package:mc_login/redux/main/main_state.dart';
import 'package:redux/redux.dart';

Reducer<MainState> mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, Logout>(_logout),
  TypedReducer<MainState, ShowError>(_showError),
  TypedReducer<MainState, CloseScreen>(_closeScreen),
  TypedReducer<MainState, ResetState>(_resetState),
]);

MainState _logout(MainState state, Logout action) {
  return state.copyWith(isLoading: true, error: null);
}

MainState _showError(MainState state, ShowError action) {
  return state.copyWith(isLoading: false, error: action.error);
}

MainState _closeScreen(MainState state, CloseScreen action) {
  return state.copyWith(
    isLoading: false,
    shouldCloseScreen: true,
    error: null,
  );
}

MainState _resetState(MainState state, ResetState action) {
  return MainState.initial();
}
