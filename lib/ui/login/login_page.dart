import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/common/validator/validator.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/ui/login/login_vm.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String _emailError;
  String _passwordError;
  bool _passwordVisibility;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisibility = false;
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  _validateFields(LoginViewModel vm) {
    bool validated = true;
    var email = _emailController.text;
    if (Validator.isEmpty(email)) {
      setState(() => _emailError = 'EMAIL CAN\'T BE EMPTY');
      validated = false;
    }
    if (!Validator.isEmpty(email) && !Validator.isEmailCorrect(email)) {
      setState(() => _emailError = 'EMAIL IS INCORRECT');
      validated = false;
    }

    if (validated) {
      setState(() {
        _emailError = null;
      });
    }

    final password = _passwordController.text;
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
      _emailError = null;
      _passwordError = null;

      vm.login(email, password);
    }
  }

  _onInit(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onDispose(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onWillChange(LoginViewModel vm) {
    if (vm.isDefault) return;
    if (vm.user == null) return;
    vm.resetState();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.main_page,
      (Route<dynamic> route) => false,
      arguments: vm.user,
    );
  }

  _onDidChange(LoginViewModel vm) {
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

  _showRegisterPage() {
    Navigator.of(context).pushNamed(
      AppRoutes.register_page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoreConnector(
        distinct: true,
        converter: LoginViewModel.fromStore,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        builder: (BuildContext context, LoginViewModel vm) {
          if (vm.loading) {
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
                                Container(
                                  margin: EdgeInsets.only(bottom: 24),
                                  child: Image.asset(
                                    "assets/images/imgLogo.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Text(
                                  "Welcome back!",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff484848)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 7),
                                ),
                                Text(
                                  "Sign in to continue.",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff979797)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 56),
                                ),
                                TextField(
                                  controller: _emailController,
                                  onSubmitted: (email) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: "Email",
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
                                    errorText: _emailError,
                                  ),
                                ),
                                TextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
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
                                    "SIGN IN",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff53cde4),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 90),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff979797),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showRegisterPage();
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff979797),
                                        ),
                                      ),
                                    ),
                                  ],
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
          }
        },
      ),
    );
  }
}
