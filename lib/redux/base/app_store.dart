import 'package:mc_login/data/repo/auth_repo.dart';
import 'package:mc_login/redux/base/app_middleware.dart';
import 'package:mc_login/redux/base/app_reducer.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> appStore(sharedPreferences) async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(AuthRepo(sharedPreferences)),
  );
}
