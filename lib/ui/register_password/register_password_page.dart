import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/common/validator/validator.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/ui/register_password/register_password_vm.dart';
import 'package:redux/redux.dart';

class RegisterPasswordPageArguments {
  final String email;

  RegisterPasswordPageArguments({this.email});
}

class RegisterPasswordPage extends StatefulWidget {
  final RegisterPasswordPageArguments arguments;

  RegisterPasswordPage({this.arguments});

  @override
  _RegisterPasswordPageState createState() =>
      _RegisterPasswordPageState(email: arguments.email);
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _passwordController;
  String _passwordError;
  String email;
  bool _passwordVisibility;

  _RegisterPasswordPageState({this.email});

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _passwordController = TextEditingController();
    _passwordVisibility = false;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  _validateFields(RegisterPasswordViewModel vm) {
    bool validated = true;
    var password = _passwordController.text;
    if (Validator.isEmpty(password)) {
      setState(() => _passwordError = 'PASSWORD CAN\'T BE EMPTY');
      validated = false;
    }
    if (!Validator.isEmpty(password) &&
        !Validator.isPasswordCorrect(password)) {
      setState(() => _passwordError = 'PASSWORD IS INCORRECT');
      validated = false;
    }

    if (validated) {
      _passwordError = null;
      vm.register(email, password);
    }
  }

  _onInit(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onDispose(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onWillChange(RegisterPasswordViewModel vm) {
    if (vm.isDefault) return;
    vm.resetState();
  }

  _onDidChange(RegisterPasswordViewModel vm) {
    if (vm.isDefault) return;
    if(vm.error != null) {
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
    if (vm.user == null) return;
    vm.resetState();


    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.main_page, (Route<dynamic> route) => false,
    arguments: vm.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoreConnector(
        distinct: true,
        converter: RegisterPasswordViewModel.fromStore,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        builder: (BuildContext context, RegisterPasswordViewModel vm) {
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
                              InkWell(
                                child: Icon(Icons.arrow_back_ios),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                              ),
                              Text(
                                "Enter password to continue",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff979797)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 56),
                              ),
                              TextField(
                                controller: _passwordController,
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                                obscureText: !_passwordVisibility,
                                decoration: InputDecoration(
                                  suffix: GestureDetector(
                                    child: Icon(
                                      _passwordVisibility
                                          ? Icons.remove_red_eye
                                          : Icons.panorama_fish_eye,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _passwordVisibility =
                                            !_passwordVisibility;
                                      });
                                    },
                                  ),
                                  alignLabelWithHint: true,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: Color(0xffd8d8d8),
                                    fontSize: 18,
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffd8d8d8),
                                    ),
                                  ),
                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff53cde4),
                                    ),
                                  ),
                                  errorText: _passwordError,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 87),
                              ),
                              InkWell(
                                onTap: () {
                                  _validateFields(vm);
                                },
                                child: Text(
                                  "REGISTER",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff53cde4),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                              )
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
        },
      ),
    );
  }
}
