import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appMiddleware(AuthRepo authRepo) {
  final appMiddleware = <Middleware<AppState>>[];
  appMiddleware.addAll(LoginMiddleware(authRepo).getMiddleware());
  return appMiddleware;
}
