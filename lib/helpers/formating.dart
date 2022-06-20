import 'package:intl/intl.dart';

class Formating {
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String upperCaseFrist(String str) {
    return str.substring(0, 1).toUpperCase() + str.substring(1);
  }

  int sumString(String str) {
    int sum = 0;
    for (int i = 0; i < str.length; i++) {
      sum += int.parse(str[i]);
    }
    return sum;
  }
}
