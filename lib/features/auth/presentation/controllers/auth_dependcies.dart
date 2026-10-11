import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mysen/features/auth/data/repositories/auth_repository.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';
import 'package:mysen/features/auth/domain/usecases/check_and_link_user.dart';
import 'package:mysen/features/auth/domain/usecases/create_patient_user.dart';
import 'package:mysen/features/auth/domain/usecases/get_user_deatils.dart';
import 'package:mysen/features/auth/domain/usecases/sign_in.dart';
import 'package:mysen/features/auth/domain/usecases/sign_out.dart';
import 'package:mysen/features/auth/domain/usecases/sign_up.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_gate_provider.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImp(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
    internetService: ref.watch(internetServiceProvider),
  ),
);
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(client: client),
);

final signInProvider = Provider<SignIn>(
  (ref) => SignIn(repository: ref.watch(authRepositoryProvider)),
);
final signUpProvider = Provider<SignUp>(
  (ref) => SignUp(repository: ref.watch(authRepositoryProvider)),
);
final signOutProvider = Provider<SignOut>(
  (ref) => SignOut(repository: ref.watch(authRepositoryProvider)),
);
final getUserDeatilsProvider = Provider<GetUserDeatils>(
  (ref) => GetUserDeatils(repository: ref.watch(authRepositoryProvider)),
);
final checkAndLinkUserProvider = Provider<CheckAndLinkUser>(
  (ref) => CheckAndLinkUser(repository: ref.watch(authRepositoryProvider)),
);
final createPatientUserProvider = Provider<CreatePatientUser>(
  (ref) => CreatePatientUser(repository: ref.watch(authRepositoryProvider)),
);
final authGateProvider = AsyncNotifierProvider<AuthGateProvider, AuthState>(
  AuthGateProvider.new,
);
final authProvider = AsyncNotifierProvider<AuthProvider, void>(
  AuthProvider.new,
);
final phoneProvider = StateProvider<String>((ref) {
  return '';
});
final codeSendProvider = StateProvider<String>((ref) {
  return '';
});
final isBackProvider = StateProvider<bool>((ref) {
  return false;
});
