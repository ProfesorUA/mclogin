import 'package:equatable/equatable.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:meta/meta.dart';

@immutable
class RegisterState extends Equatable {
  final bool isLoading;
  final User user;
  final Object error;

  RegisterState({
    this.isLoading,
    this.user,
    this.error,
  }) : super([
          isLoading,
          user,
          error,
        ]);

  factory RegisterState.initial() {
    return RegisterState(
      isLoading: false,
      user: null,
      error: null,
    );
  }

  RegisterState copyWith({
    bool isLoading,
    User user,
    Object error,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }

  bool isDefault() {
    return isLoading == false && user == null && error == null;
  }
}
