extension DateTimeExtension on DateTime {
  String convertToDateDDMMAAAA () {
    String daString = day.toString();
    String monthString = month.toString();
    if (day < 10) {
      daString = day.toString().padLeft(2, '0');
    }
    if (month < 10) {
      monthString = month.toString().padLeft(2, '0');
    }
    return '$daString/$monthString/$year';
  }
}
