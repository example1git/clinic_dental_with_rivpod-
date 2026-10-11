import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/treament/data/datasources/treatment_local_data_source.dart';
import 'package:mysen/features/treament/data/datasources/treatment_remote_data_source.dart';
import 'package:mysen/features/treament/data/repositories/treatment_repository.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/usecases/delete_treatment.dart';
import 'package:mysen/features/treament/domain/usecases/get_treatment_case.dart';
import 'package:mysen/features/treament/domain/usecases/get_treatment_case_by_dp_id.dart';
import 'package:mysen/features/treament/presentation/controllers/treatments_provider.dart';

final treatemntRepositoryProvider = Provider<TreatmentRepositoryImp>(
  (ref) => TreatmentRepositoryImp(
    internetService: ref.watch(internetServiceProvider),
    treatmentRemoteDataSource: ref.watch(treatmentRemoteDataSourceProvider),
    treatmentLocalDataSource: ref.watch(treatmentLocalDataSourceProvider),
  ),
);
final treatmentRemoteDataSourceProvider = Provider<TreatmentRemoteDataSource>(
  (ref) => TreatmentRemoteDataSource(client: client),
);
final treatmentLocalDataSourceProvider = Provider<TreatmentLocalDataSource>(
  (ref) => TreatmentLocalDataSource(),
);
final getTreatmentsProvider = Provider<GetTreatmentCase>(
  (ref) => GetTreatmentCase(repository: ref.watch(treatemntRepositoryProvider)),
);
final getTreatmentByDpIDProvider = Provider<GetTreatmentCaseByDpId>(
  (ref) => GetTreatmentCaseByDpId(
    repository: ref.watch(treatemntRepositoryProvider),
  ),
);
final deleteTreatmentProvider = Provider<DeleteTreatment>(
  (ref) => DeleteTreatment(repository: ref.watch(treatemntRepositoryProvider)),
);
final treatmentProvider =
    AsyncNotifierProvider<TreatmentsProvider, List<TreatmentCase>>(
      TreatmentsProvider.new,
    );
