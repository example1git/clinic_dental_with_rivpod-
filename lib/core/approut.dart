import 'package:go_router/go_router.dart';
import 'package:mysen/features/appointment/presentation/pages/all_appointment_day.dart';
import 'package:mysen/features/auth/presentation/pages/sigin_screen.dart';
import 'package:mysen/features/auth/presentation/pages/sign_up_complete.dart';
import 'package:mysen/features/auth/presentation/pages/sigup_screen.dart';
import 'package:mysen/features/auth/presentation/pages/start_screen.dart';
import 'package:mysen/features/auth/presentation/pages/verify.dart';
import 'package:mysen/features/doctor/presentation/pages/doctor_profile.dart';
import 'package:mysen/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:mysen/features/patient/presentation/pages/patient_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const startscreen = '/startscreen';
  static const sigin = '/sigin';
  static const sigup = '/sigup';
  static const sigupcomplte = '/sigupcomplte';
  static const verfiy = '/verfiy';
  static const doctor = '/doctor';
  static const doctorProfile = '/doctorProfile';
  static const notifications = '/notifications';
  static const mainscreen = '/mainscreen';
  static const patientBody = '/patientBody';
  static const allreserve = '/allreserve';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.startscreen,

  routes: [
    GoRoute(
      path: AppRoutes.startscreen,
      name: 'startscreen',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: Startscreen());
      },
    ),
    GoRoute(
      path: AppRoutes.sigin,
      name: 'sigin',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: SiginScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.sigup,
      name: 'sigup',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: SigupScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.verfiy,
      name: 'verfiy',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: Verify());
      },
    ),
    GoRoute(
      path: AppRoutes.sigupcomplte,
      name: 'sigupcomplte',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: SignUpComplete());
      },
    ),
    GoRoute(
      path: AppRoutes.doctor,
      name: 'doctor',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: DoctorScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.doctorProfile,
      name: 'doctorProfile',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: DoctorProfile());
      },
    ),
    GoRoute(
      path: AppRoutes.allreserve,
      name: 'allreserve',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: AllAppointmenteday());
      },
    ),
    // GoRoute(
    //   path: AppRoutes.patientBody,
    //   name: 'patientBody',
    //   pageBuilder: (context, state) {
    //     return NoTransitionPage(child: AllAppointmenteday());
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.login,
    //   name: 'login',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: LoginScreen(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.mainscreen,
    //   name: 'mainscreen',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: Mainscreen(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.reservation,
    //   name: 'reservation',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: Reservation(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.doctor,
    //   name: 'doctor',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: Doctorscreen(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.doctorEditing,
    //   name: 'doctorEditing',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: DoctorEditing(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.allreserve,
    //   name: 'allreserve',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: Allreserveday(),
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: AppRoutes.notifications,
    //   name: 'notifications',
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: Notfictionscreen(),
    //     );
    //   },
    // ),
  ],
);
