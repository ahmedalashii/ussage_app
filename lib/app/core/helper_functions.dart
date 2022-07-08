import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../data/models/user.dart';

User? loggedInUser;

String formatTimeOfDay(DateTime? dateAndTime) {
  final format = DateFormat.jm();
  return format.format(dateAndTime!);
}

DateTime? toDateTime(Timestamp? value) {
  if (value == null) return null;

  return value.toDate();
}

dynamic fromDateTimeToJson(DateTime? date) {
  if (date == null) return null;

  return date.toUtc();
}
