import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mc_login/common/constants/keys.dart';
import 'package:mc_login/common/validator/validator.dart';
import 'package:mc_login/redux/base/app_state.dart';
import 'package:mc_login/ui/register_email/register_email_vm.dart';
import 'package:mc_login/ui/register_password/register_password_page.dart';
import 'package:redux/redux.dart';

class RegisterEmailPage extends StatefulWidget {
  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _emailController;
  String _emailError;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  _validateFields(RegisterEmailViewModel vm) {
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
      _emailError = null;
      Navigator.of(context).pushNamed(AppRoutes.register_password_page,
          arguments:
              RegisterPasswordPageArguments(email: _emailController.text));
    }
  }

  _onInit(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onDispose(Store<AppState> store) {
    if (store.state.loginState.isDefault()) return;
  }

  _onWillChange(RegisterEmailViewModel vm) {
    vm.resetState();
  }

  _onDidChange(RegisterEmailViewModel vm) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoreConnector(
        distinct: true,
        converter: RegisterEmailViewModel.fromStore,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        builder: (BuildContext context, RegisterEmailViewModel vm) {
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
                                "Enter email to continue.",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff979797)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 56),
                              ),
                              TextField(
                                controller: _emailController,
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
                              Padding(
                                padding: EdgeInsets.only(top: 87),
                              ),
                              InkWell(
                                onTap: () {
                                  _validateFields(vm);
                                },
                                child: Text(
                                  "CONTINUE",
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
