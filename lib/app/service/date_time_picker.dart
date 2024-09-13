import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> datePick(context,
    {DateTime? initDate, DateTime? firstDate, DateTime? lastDate}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(DateTime.now().year - 50),
    lastDate: lastDate ?? DateTime.now(),
  );
  return selectedDate;
}

Future<TimeOfDay?> pickTime(BuildContext context,
    {TimeOfDay? currentSelectedTime}) async {
  final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: currentSelectedTime ?? TimeOfDay.now(),
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      });

  return pickedS;
}

String carStartEndDateFormat({required DateTime date}) {
  String formated = DateFormat('E, MMM d \'at\' h:mm a').format(date);
  return formated;
}

String carOnlyDateFormat({required DateTime date}) {
  String formated = DateFormat('MMM d, yyyy').format(date);
  return formated;
}

String carOnlyTimeFormat({required DateTime date}) {
  String formated = DateFormat('h:mm a').format(date);
  return formated;
}
