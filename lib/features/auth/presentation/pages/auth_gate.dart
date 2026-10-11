import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_gate_provider.dart';
import 'package:mysen/features/auth/presentation/pages/sigin_screen.dart';
import 'package:mysen/features/auth/presentation/pages/sign_up_complete.dart';
import 'package:mysen/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:mysen/features/patient/presentation/pages/patient_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authGateProvider);
    return auth.when(
      data: (data) {
        if (data.authStateEnum == AuthStateEnum.auth &&
            data.role == Role.doctor) {
          return DoctorScreen();
        }
        if (data.authStateEnum == AuthStateEnum.auth &&
            data.role == Role.user) {
          return PatientScreen();
        }
        if (data.authStateEnum == AuthStateEnum.sigup && data.role == null) {
          return SignUpComplete();
        }
        return SiginScreen();
      },
      error: (error, stackTrace) {
        return Container(
          color: context.primarycolor,
          child: Center(child: Text('error')),
        );
      },
      loading: () {
        return Container(
          color: context.primarycolor,
          child: Center(
            child: CircularProgressIndicator(color: context.primaryContainer),
          ),
        );
      },
    );
  }
}
