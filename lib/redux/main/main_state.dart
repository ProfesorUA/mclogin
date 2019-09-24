import 'package:equatable/equatable.dart';
import 'package:mc_login/data/models/User.dart';
import 'package:meta/meta.dart';

@immutable
class MainState extends Equatable {
  final bool isLoading;
  final bool shouldCloseScreen;
  final Object error;

  MainState({
    this.isLoading,
    this.shouldCloseScreen,
    this.error,
  }) : super([
    isLoading,
    shouldCloseScreen,
    error,
  ]);

  factory MainState.initial() {
    return MainState(
      isLoading: false,
      shouldCloseScreen: false,
      error: null,
    );
  }

  MainState copyWith({
    bool isLoading,
    bool shouldCloseScreen,
    Object error,
  }) {
    return MainState(
      isLoading: isLoading,
      shouldCloseScreen: shouldCloseScreen,
      error: error,
    );
  }

  bool isDefault() {
    return isLoading == false && shouldCloseScreen == false && error == null;
  }
}
