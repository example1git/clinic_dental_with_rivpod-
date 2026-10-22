import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/features/doctor/presentation/widgets/card_dp.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/treament/presentation/pages/treatment_case.dart';

class BodyPatient extends StatelessWidget {
  const BodyPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(doctorPatientProvider);
          return provider.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final dp = data[index];

                  return CardPatient(
                    title: Text(
                      dp.doctorFullName,
                      style: context.bodyLarge,
                      textAlign: TextAlign.center,
                    ),

                    trailing: IconButton(
                      style: context.iconButtonStyle,

                      onPressed: () {
                        Utils.showMyDialog(
                          heightFactor: .3,
                          widthFactor: .8,

                          colorDialog: context.colorScheme.error,
                          context: context,
                          child: Alert(
                            isLoading: provider.isLoading,
                            confirme: () {
                              ref
                                  .read(doctorPatientProvider.notifier)
                                  .deleteDoctorPatient(
                                    dp.copyWith(isDeletePatient: true),
                                  );
                              context.pop();
                            },

                            title: context.tr.deleteConfirmation,
                          ),
                        );
                      },
                      icon: Icon(Icons.delete, color: context.primaryContainer),
                    ),

                    leading: IconButton(
                      style: context.iconButtonStyle,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                TreatmentCaseScreen(dp: dp, isDoctor: false),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_sharp),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text('error'));
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(
                  color: context.primaryContainer,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
