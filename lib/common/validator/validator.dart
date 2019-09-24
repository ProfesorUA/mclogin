class Validator {
  static const EMAIL_PATTERN = r"^[a-zA-Z0-9.-_]+@[a-zA-Z0-9.-_]+\.[a-zA-Z]+$";
  static const PASSWORD_PATTERN = r"^[a-zA-Z0-9]{6,12}$";

  static bool isEmpty(final String string) {
    return (string == null || string.isEmpty);
  }

  static bool isEmailCorrect(final String email) {
    final RegExp regExp = RegExp(EMAIL_PATTERN);
    return regExp.hasMatch(email);
  }

  static bool isPasswordCorrect(final String password) {
    final RegExp regExp = RegExp(PASSWORD_PATTERN);
    return regExp.hasMatch(password);
  }
}
