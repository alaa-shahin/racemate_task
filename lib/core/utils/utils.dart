import 'package:intl/intl.dart';

String formatDateToYYYYMMDD(String dateString) {
  final format = DateFormat("EEEE, MMM d, yyyy");
  final parsedDate = format.parse(dateString);
  final formattedDate = DateFormat('d MMM, yyyy').format(parsedDate);
  return formattedDate;
}

String formatDate(String rawDate) {
  // Check if the date string has the expected length (8 digits)
  if (rawDate.length != 8) {
    print("Invalid date format. Expected YYYYMMDD.");
  }
  final year = int.parse(rawDate.substring(0, 4));
  final month = int.parse(rawDate.substring(4, 6));
  final day = int.parse(rawDate.substring(6, 8));
  final dateTime = DateTime(year, month, day);
  final formatter = DateFormat('d MMMM, yyyy');
  final formattedDate = formatter.format(dateTime);
  return formattedDate;
}
