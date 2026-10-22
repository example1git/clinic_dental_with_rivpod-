import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class DoctorsProvider extends AsyncNotifier<List<Doctor>> {
  @override
  FutureOr<List<Doctor>> build() async {
    final getDoctors = await ref.read(getDoctorsProvider)();
    return getDoctors.fold(
      (l) {
        Error.throwWithStackTrace(l, StackTrace.current);
      },
      (r) {
        return r;
      },
    );
  }
}
