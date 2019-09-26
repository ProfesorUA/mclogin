import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences _sharedPreferences;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthRepo(this._sharedPreferences);

  Future<User> login(String email, String password) async {

    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User user = User.fromMap({ "email": result.user.email });
    await _sharedPreferences.setString("user", user.toJson());

    return user;
  }

  Future<User> register(String email, String password) async {

    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User user = User.fromMap({ "email": result.user.email });
    await _sharedPreferences.setString("user", user.toJson());

    return user;
  }

  Future<dynamic> logout() async {

    await _firebaseAuth.signOut();
    await _sharedPreferences.remove("user");
  }
}