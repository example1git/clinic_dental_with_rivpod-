import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/patient/presentation/pages/main_screen.dart';

class PatientScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    return Scaffold(
      backgroundColor: context.primarycolor,
      body: patient.when(
        data: (data) {
          if (data != null) {
            return MainScreen(patient: data);
          }
          return SizedBox.shrink();
        },
        error: (error, stackTrace) => CustomErrorWidget(
          error: error,
          onPressed: () {
            ref.invalidate(patientProvider);
          },
          isScaffold: true,
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
      ),
    );
  }
}
