import 'package:fork_mate/functions/create_snack_bar.dart';

bool validatePassword(String? password) {
  if (password == null) return false;
  if (password.length < 8) {
    createSnackBar(message: 'Password too short! Need at least 8 characters');
    return false;
  }
  bool hasLetters = password.contains(RegExp(r'[a-zA-Z]'));
  if (!hasLetters) {
    createSnackBar(message: 'Password must contain at least one letter');
    return false;
  }
  bool hasNumbers = password.contains(RegExp(r'[0-9]'));
  if (!hasNumbers) {
    createSnackBar(message: "Password must contain at least one number");
    return false;
  }
  return true;
}
