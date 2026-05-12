String formatPrice(double number) {
  String numStr = number.toStringAsFixed(1);
  List<String> parts = numStr.split('.');
  String integerPart = parts[0];
  String formattedInteger = '';

  for (int i = integerPart.length - 1, count = 0; i >= 0; i--, count++) {
    if (count % 3 == 0 && count != 0) {
      formattedInteger = ',$formattedInteger';
    }
    formattedInteger = integerPart[i] + formattedInteger;
  }
  return parts.length > 1 ? '$formattedInteger.${parts[1]}' : formattedInteger;
}
