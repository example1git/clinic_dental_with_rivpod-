import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentDateProvider extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setTime(TimeOfDay time) {
    state = DateTime(
      state.year,
      state.month,
      state.day,
      time.hour,
      time.minute,
    );
  }

  void setDate(DateTime date) {
    state = DateTime(date.year, date.month, date.day, state.hour, state.minute);
  }
}
