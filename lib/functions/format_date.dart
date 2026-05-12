import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final formattedDate = DateFormat('dd/MM/yy').format(dateTime);
  final formattedTime = DateFormat('hh:mm a').format(dateTime);
  return '$formattedDate - $formattedTime';
}
