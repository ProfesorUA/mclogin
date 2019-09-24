import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/redux/main/main_actions.dart';
import 'package:redux/redux.dart';

class MainMiddleware {
  final AuthRepo authRepo;

  MainMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, Logout>(_logout),
    ];
  }

  Future _logout(
      Store<AppState> store,
      Logout action,
      NextDispatcher next,
      ) async {
    next(action);
    await authRepo.logout();
    store.dispatch(CloseScreen());
  }
}