import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_gate_provider.dart';

class AuthProvider extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signIn(String phone) async {
    state = const AsyncLoading();

    await ref.read(signInProvider)('$phone@gmail.com', phone);

    final user = await ref.read(getUserDeatilsProvider)();
    final authGateNotifier = ref.read(authGateProvider.notifier);

    return user.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        if (r != null) {
          if (r.role == Role.doctor.name) {
            final authSatte = AuthState(
              authStateEnum: AuthStateEnum.auth,
              role: Role.doctor,
            );
            authGateNotifier.setSatate(authSatte);

            ref.read(sharedPrefServiceProvider).setRole(Role.doctor);
            return;
          }
          if (r.role == Role.user.name) {
            final authSatte = AuthState(
              authStateEnum: AuthStateEnum.auth,
              role: Role.user,
            );

            authGateNotifier.setSatate(authSatte);

            ref.read(sharedPrefServiceProvider).setRole(Role.user);
            return;
          }
        }
        final authSatte = AuthState(
          authStateEnum: AuthStateEnum.sigup,
          role: null,
        );

        authGateNotifier.setSatate(authSatte);
      },
    );
  }

  Future<void> signUp() async {
    state = const AsyncLoading();

    final phone = ref.read(phoneProvider.notifier).state;
    await ref.read(signUpProvider)('$phone@gmail.com', phone);

    final result = await ref.read(checkAndLinkUserProvider)(phone);
    final authGateNotifier = ref.read(authGateProvider.notifier);
    ref.read(phoneProvider);
    return result.fold(
      (l) {
        print('errrrrrrrrrrrrrrrrrrrrrrrrrrr');
        state = AsyncValue.error(l, StackTrace.current);
        ref.watch(isBackProvider.notifier).state = true;
      },
      (r) {
        print('succccccccccccccccccccccccccccccccc');
        print(r);
        if (r == Role.doctor.name) {
          final authSatte = AuthState(
            authStateEnum: AuthStateEnum.auth,
            role: Role.doctor,
          );

          authGateNotifier.setSatate(authSatte);

          ref.read(sharedPrefServiceProvider).setRole(Role.doctor);
          return;
        }
        if (r == Role.user.name) {
          final authSatte = AuthState(
            authStateEnum: AuthStateEnum.auth,
            role: Role.user,
          );

          authGateNotifier.setSatate(authSatte);

          ref.read(sharedPrefServiceProvider).setRole(Role.user);
          return;
        }
        final authSatte = AuthState(
          authStateEnum: AuthStateEnum.sigup,
          role: null,
        );

        authGateNotifier.setSatate(authSatte);
      },
    );
  }

  Future<void> signUpComplete(String name, String nickName) async {
    state = const AsyncLoading();
    final fullName = ('${name.trim()} ${nickName.trim()}').replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    final phone = ref.read(phoneProvider.notifier).state;

    final result = await ref.read(createPatientUserProvider)(phone, fullName);
    final authGateNotifier = ref.read(authGateProvider.notifier);

    return result.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final authSatte = AuthState(
          authStateEnum: AuthStateEnum.auth,
          role: Role.user,
        );

        authGateNotifier.setSatate(authSatte);

        ref.read(sharedPrefServiceProvider).setRole(Role.user);
      },
    );
  }

  Future<void> signOut() async {
    final result = await ref.read(signOutProvider)();
    final authGateNotifier = ref.read(authGateProvider.notifier);

    return result.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final authSatte = AuthState(
          authStateEnum: AuthStateEnum.sigin,
          role: null,
        );

        ref.read(sharedPrefServiceProvider).removeRole();
        authGateNotifier.setSatate(authSatte);
      },
    );
  }

  Future<void> resendCode() async {
    final phone = ref.read(phoneProvider.notifier).state;
    if (phone.isEmpty) {
      return;
    }
    final List<String> code = phone.split('');
    code.shuffle();
    String codeSend = code.sublist(0, 4).join();
    await Future.delayed(Duration(seconds: 2));
    await ref.read(localNotificationServiceProvider).cancelAll();

    await ref
        .read(localNotificationServiceProvider)
        .showInstantNotification(title: 'Code', body: codeSend);
    ref.read(codeSendProvider.notifier).state = codeSend;
    ref.watch(isBackProvider.notifier).state = false;
  }
}
