import 'package:intl/intl.dart';

class DateFormatter {
  static DateFormat longDate = DateFormat.yMMMMd();
}

class RelationalDateFormatter {
  static String formatInDay(DateTime? dateTime) {
    if (dateTime == null) return '';

    final todayDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final referenceDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    switch (referenceDateTime.difference(todayDateTime).inDays) {
      case -1: return 'Yesterday';
      case 0: return 'Today';
      case 1: return 'Tomorrow';
    }

    return DateFormat('EEEE').format(dateTime);
  }
}