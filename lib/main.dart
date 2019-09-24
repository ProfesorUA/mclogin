import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/redux/base/app_store.dart';
import 'package:mc_login/redux/login/login_actions.dart';
import 'package:mc_login/ui/login/login_page.dart';
import 'package:mc_login/ui/register_email/register_email_page.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final store = await appStore(sharedPreferences);
  final isSessionAvailable = sharedPreferences.get('user') != null;
  runApp(McLoginApp(store, isSessionAvailable));
}

class McLoginApp extends StatefulWidget {
  final Store<AppState> store;
  final bool isSessionAvailable;

  McLoginApp(this.store, this.isSessionAvailable);

  @override
  State<StatefulWidget> createState() => McLoginAppState();
}

class McLoginAppState extends State<McLoginApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: widget.isSessionAvailable ? Text("Loggined") : LoginPage(),
        onGenerateRoute: (RouteSettings settings) {
          final routes = <String, WidgetBuilder> {
            AppRoutes.login_page: (context) => LoginPage(),
            AppRoutes.register_page: (context) => RegisterEmailPage(),
            AppRoutes.main_page: (context) => Text("Main page"),
          };

          final builder = routes[settings.name];
          return MaterialPageRoute(builder: (context) => builder(context));
        },
      ),
    );
  }
}