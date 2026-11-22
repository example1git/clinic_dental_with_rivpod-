import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/utiles.dart';

enum AuthStateEnum { sigin, sigup, auth }

class AuthState {
  final AuthStateEnum authStateEnum;
  final Role? role;

  new({required this.authStateEnum, required this.role});
}

class AuthGateProvider extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() {
    final role = ref.read(sharedPrefServiceProvider).getRole();

    if (role == Role.doctor.name) {
      return AuthState(authStateEnum: AuthStateEnum.auth, role: Role.doctor);
    }
    if (role == Role.user.name) {
      return AuthState(authStateEnum: AuthStateEnum.auth, role: Role.user);
    }

    return AuthState(authStateEnum: AuthStateEnum.sigin, role: null);
  }

  void setStateAuth(AuthState authState) {
    state = AsyncData(authState);
  }
}
