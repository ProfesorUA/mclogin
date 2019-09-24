import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_reducer.dart';
import 'package:mc_login/redux/main/main_reducer.dart';
import 'package:mc_login/redux/register/register_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      loginState: loginReducer(state.loginState, action),
      registerState: registerReducer(state.registerState, action),
      mainState: mainReducer(state.mainState, action));
}
