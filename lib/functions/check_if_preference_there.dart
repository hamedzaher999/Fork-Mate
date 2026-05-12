bool checkIfPreferenceThere({
  required String? preference,
  required Map<String, double>? preferences,
}) {
  if (preferences != null && preference != null) {
    return preferences.containsKey(preference);
  }
  return false;
}
