import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/ui/main/main_vm.dart';
import 'package:redux/redux.dart';

class MainPage extends StatefulWidget {
  final User user;

  MainPage(this.user);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onInit(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onDispose(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onWillChange(MainViewModel vm) {
    if (vm.isDefault) return;
    if (!vm.shouldCloseScreen) return;
    vm.resetState();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login_page,
      (Route<dynamic> route) => false,
    );
  }

  _onDidChange(MainViewModel vm) {
    if (vm.isDefault) return;
    if (vm.error == null) return;
    vm.resetState();
    String message;
    if (vm.error is PlatformException) {
      PlatformException pe = vm.error;
      message = pe.message;
    } else {
      message = vm.error.toString();
    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoreConnector(
        distinct: true,
        converter: MainViewModel.fromStore,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        builder: (BuildContext context, MainViewModel vm) {
          if (vm.isLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 44),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: Container(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.email),
                                InkWell(
                                  onTap: () {
                                    vm.logout();
                                  },
                                  child: Text("Logout"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
