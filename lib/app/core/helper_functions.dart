
import 'package:intl/intl.dart';

String formatTimeOfDay(DateTime dateAndTime) {
  final format = DateFormat.jm();
  return format.format(dateAndTime);
}