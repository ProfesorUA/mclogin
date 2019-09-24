import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState extends Equatable {
  final bool isLoading;
  final FirebaseUser user;
  final Object error;

  LoginState({
    this.isLoading,
    this.user,
    this.error,
  }) : super([
    isLoading,
    user,
    error,
  ]);

  factory LoginState.initial() {
    return LoginState(
      isLoading: false,
      user: null,
      error: null,
    );
  }

  LoginState copyWith({
    bool isLoading,
    FirebaseUser user,
    Object error,
  }) {
    return LoginState(
      isLoading: isLoading,
      user: user,
      error: error,
    );
  }

  bool isDefault() {
    return isLoading == false && user == null && error == null;
  }
}
