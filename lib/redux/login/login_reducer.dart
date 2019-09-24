import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/login/login_state.dart';
import 'package:redux/redux.dart';

Reducer<LoginState> loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, Login>(_login),
  TypedReducer<LoginState, ShowError>(_showError),
  TypedReducer<LoginState, ShowResult>(_showResult),
  TypedReducer<LoginState, ResetState>(_resetState),
]);

LoginState _login(LoginState state, Login action) {
  return state.copyWith(isLoading: true, error: null);
}

LoginState _showError(LoginState state, ShowError action) {
  return state.copyWith(
    isLoading: false,
    error: action.error
  );
}

LoginState _showResult(LoginState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
    user: action.user,
    error: null,
  );
}

LoginState _resetState(LoginState state, ResetState action) {
  return LoginState.initial();
}