import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/core/widget/data_embity.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/core/widget/widget_loading.dart';
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
              return RefreshIndicator(
                color: context.primaryContainer,
                onRefresh: () async {
                  ref.invalidate(doctorPatientProvider);
                  MessageHandle.handleMessage(MessageType.refresh, context);
                },
                child: data.isEmpty
                    ? const DataEmbity()
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dp = data[index];

                          return CardPatient(
                            imageUrl: dp.imageUrl,
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
                                          isDoctor: false,
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
                      ),
              );
            },
            error: (error, stackTrace) {
              return CustomErrorWidget(
                error: error,
                onPressed: () {
                  ref.invalidate(doctorPatientProvider);
                },
                isScaffold: false,
              );
            },
            loading: () {
              return WidgetLoading(
                circleWidget: true,
                loading: ref.watch(doctorPatientProvider).isLoading,
              );
            },
          );
        },
      ),
    );
  }
}
