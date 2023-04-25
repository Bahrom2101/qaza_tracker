class BaseFunctions {
  BaseFunctions._();

  static bool validPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'\d'))) return false;
    return true;
  }
}
