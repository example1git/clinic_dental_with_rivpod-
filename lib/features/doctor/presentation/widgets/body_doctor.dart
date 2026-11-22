import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/card_dp.dart';
import 'package:mysen/features/doctor/presentation/widgets/search.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/treament/presentation/pages/treatment_case.dart';

class BodyDoctor extends StatelessWidget {
  const BodyDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final bool search = ref.watch(isSearch);
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: search ? Search() : null,
              );
            },
          ),

          Expanded(
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
                            dp.patientFullName,
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
                                          dp.copyWith(isDeleteDoctor: true),
                                        );
                                    context.pop();
                                  },

                                  title: context.tr.deleteConfirmation,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: context.primaryContainer,
                            ),
                          ),

                          leading: IconButton(
                            style: context.iconButtonStyle,
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => TreatmentCaseScreen(
                                        dp: dp,
                                        isDoctor: true,
                                      ),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) => FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
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
          ),
        ],
      ),
    );
  }
}
