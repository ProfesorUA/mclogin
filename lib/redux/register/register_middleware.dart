import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/register/register_actions.dart';
import 'package:redux/redux.dart';

class RegisterMiddleware {
  final AuthRepo authRepo;

  RegisterMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, Register>(_register),
    ];
  }

  Future _register(
      Store<AppState> store,
      Register action,
      NextDispatcher next,
      ) async {
    next(action);
    authRepo.register(action.email, action.password).then((user) {
      store.dispatch(ShowResult(user));
    }).catchError((error) {
      store.dispatch(RegShowError(error));
    });
  }
}