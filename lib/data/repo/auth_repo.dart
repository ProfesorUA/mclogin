import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences _sharedPreferences;

  AuthRepo(this._sharedPreferences);

  Future<FirebaseUser> login(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    AuthResult result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await _sharedPreferences.setString("user", user.toString());

    return user;
  }
}