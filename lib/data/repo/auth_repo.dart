import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:mc_login/redux/main/main_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences _sharedPreferences;

  AuthRepo(this._sharedPreferences);

  Future<User> login(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    AuthResult result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User user = User.fromMap({ "email": result.user.email });
    await _sharedPreferences.setString("user", user.toJson());

    return user;
  }

  Future<User> register(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User user = User.fromMap({ "email": result.user.email });
    await _sharedPreferences.setString("user", user.toJson());

    return user;
  }

  Future<dynamic> logout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseAuth.signOut();
    await _sharedPreferences.remove("user");
  }
}