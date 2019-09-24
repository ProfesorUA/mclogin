import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(loginState: loginReducer(state.loginState, action));
}