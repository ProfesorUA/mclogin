import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/register/register_actions.dart';
import 'package:mc_login/redux/register/register_state.dart';
import 'package:redux/redux.dart';

Reducer<RegisterState> registerReducer = combineReducers<RegisterState>([
  TypedReducer<RegisterState, Register>(_register),
  TypedReducer<RegisterState, RegShowError>(_showError),
  TypedReducer<RegisterState, ShowResult>(_showResult),
  TypedReducer<RegisterState, ResetState>(_resetState),
]);

RegisterState _register(RegisterState state, Register action) {
  return state.copyWith(isLoading: true, error: null);
}

RegisterState _showError(RegisterState state, RegShowError action) {
  return state.copyWith(
      isLoading: false,
      error: action.error,
  );
}

RegisterState _showResult(RegisterState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
    user: action.user,
    error: null,
  );
}

RegisterState _resetState(RegisterState state, ResetState action) {
  return RegisterState.initial();
}