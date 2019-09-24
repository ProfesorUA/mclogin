import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:redux/redux.dart';

class LoginMiddleware {
  final AuthRepo authRepo;

  LoginMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, Login>(_login),
    ];
  }

  Future _login(
      Store<AppState> store,
      Login action,
      NextDispatcher next,
      ) async {
    next(action);
    authRepo.login(action.email, action.password).then((user) {
      store.dispatch(ShowResult(user));
    }).catchError((error) {
      store.dispatch(ShowError(error));
    });
  }
}