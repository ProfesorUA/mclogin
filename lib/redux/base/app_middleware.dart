import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_middleware.dart';
import 'package:mc_login/redux/main/main_middleware.dart';
import 'package:mc_login/redux/register/register_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appMiddleware(AuthRepo authRepo) {
  final appMiddleware = <Middleware<AppState>>[];
  appMiddleware.addAll(LoginMiddleware(authRepo).getMiddleware());
  appMiddleware.addAll(RegisterMiddleware(authRepo).getMiddleware());
  appMiddleware.addAll(MainMiddleware(authRepo).getMiddleware());
  return appMiddleware;
}
