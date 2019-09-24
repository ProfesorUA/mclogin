import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/base/app_store.dart';
import 'package:mc_login/ui/login/login_page.dart';
import 'package:mc_login/ui/main/main_page.dart';
import 'package:mc_login/ui/register_email/register_email_page.dart';
import 'package:mc_login/ui/register_password/register_password_page.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final store = await appStore(sharedPreferences);
  User user;
  if (sharedPreferences.get('user') != null) {
    user = User.userFromJson(sharedPreferences.get('user'));
  }
  runApp(McLoginApp(store, user));
}

class McLoginApp extends StatefulWidget {
  final Store<AppState> store;
  final User user;

  McLoginApp(this.store, this.user);

  @override
  State<StatefulWidget> createState() => McLoginAppState();
}

class McLoginAppState extends State<McLoginApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: widget.user != null ? MainPage(widget.user) : LoginPage(),
        onGenerateRoute: (RouteSettings settings) {
          final routes = <String, WidgetBuilder> {
            AppRoutes.login_page: (context) => LoginPage(),
            AppRoutes.register_page: (context) => RegisterEmailPage(),
            AppRoutes.register_password_page: (context) => RegisterPasswordPage(arguments: settings.arguments,),
            AppRoutes.main_page: (context) => MainPage(settings.arguments),
          };

          final builder = routes[settings.name];
          return MaterialPageRoute(builder: (context) => builder(context));
        },
      ),
    );
  }
}