import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/pages/patient_screen.dart';
import 'package:mysen/features/patient/presentation/widgets/card_doctor.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainScreen extends ConsumerStatefulWidget {
  const new({super.key, required this.patient});
  final Patient patient;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late PageController doctorsPageController;
  late PageController pageControllerCard;

  StreamSubscription<bool>? subscription;
  late final RealtimeChannel channel;

  int currentpage = 0;

  Future<void> getNotifications(List<Doctor> doctors) async {
    final localNotificationService = ref.read(localNotificationServiceProvider);
    final requests = await ref.read(requestReservationProvider.future);
    await localNotificationService.cancelAll();

    final now = DateTime.now();
    final requestsCheck = requests.where(
      (p0) =>
          p0.stateRequest == StateRequest.accepted ||
          p0.stateRequest == StateRequest.completed,
    );

    for (final r in requestsCheck) {
      if (r.reciveTime == null) continue;
      if (r.reciveTime!.isBefore(now)) continue;

      final doctor = doctors.firstWhere((d) => d.id == r.doctorID);

      await localNotificationService.scheduleAppointmentReminder(
        appointmentTime: r.reciveTime!,
        doctorName: doctor.fullName,
      );
    }
  }

  Future<void> changeStateRequest() async {
    if (!await ref.read(internetServiceProvider).checkNow()) {
      return;
    }

    final requests = await ref.read(requestReservationProvider.future);
    final now = await NTP.now();
    final nowDate = DateTime(now.year, now.month, now.day);
    final requestsCheck = requests.where(
      (p0) =>
          p0.stateRequest == StateRequest.completed ||
          p0.stateRequest == StateRequest.accepted,
    );

    try {
      for (var r in requestsCheck) {
        if (r.reciveTime == null) continue;
        final receiveDate = DateTime(
          r.reciveTime!.year,
          r.reciveTime!.month,
          r.reciveTime!.day,
        );

        final isAfterDay = nowDate.isAfter(receiveDate);

        if (isAfterDay) {
          ref
              .read(requestReservationProvider.notifier)
              .updateRequestReservation(
                r.copyWith(stateRequest: StateRequest.none),
              );
        }
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    doctorsPageController = PageController();
    pageControllerCard = PageController();
    pageControllerCard.addListener(() {
      doctorsPageController.animateTo(
        pageControllerCard.offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
    doctorsPageController.addListener(() {
      if (doctorsPageController.page != null) {
        currentpage = doctorsPageController.page!.round();
      }
    });

    subscription = ref
        .read(internetServiceProvider)
        .onStatusChange
        .distinct()
        .listen((hasInternet) {
          if (hasInternet) {
            changeStateRequest();
          }
        });

    channel = Utils.setupRealtimeChannel(
      tableName: 'requestreservation',

      onInsert: (payload) async {
        ref.invalidate(requestReservationProvider);
      },

      onUpdate: (payload) async {
        ref.invalidate(requestReservationProvider);
      },
    );
  }

  @override
  void dispose() {
    doctorsPageController.dispose();
    pageControllerCard.dispose();

    client.removeChannel(channel);

    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getdoctorsProvider = ref.watch(doctorsProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!await ref.read(internetServiceProvider).checkNow()) {
            if (!context.mounted) {
              return;
            }
            ErrorHndel.handleError(ErrorType.internet, context);

            return;
          }
          if (!context.mounted) {
            return;
          }
          MessageHandle.handleMessage(MessageType.add, context);
        },
      ),
      backgroundColor: context.primarycolor,

      body: getdoctorsProvider.when(
        data: (data) {
          getNotifications(data);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: data.length,
                    controller: doctorsPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final doctor = data[index];
                      String? imgurl = doctor.imgUrl;

                      return FittedBox(
                        fit: BoxFit.cover,
                        child: imgurl == null || imgurl == ''
                            ? const SizedBox.shrink()
                            : CachedNetworkImage(
                                imageUrl: imgurl,

                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              ),
                      );
                    },
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: blackcolor.withAlpha(100)),
                ),
                Positioned.fill(
                  child: PageView(
                    controller: pageControllerCard,
                    children: [
                      ...List.generate(
                        data.length,
                        (index) =>
                            CardDoctor(
                              doctor: data[index],

                              patient: widget.patient,
                            ).animate().shimmer(
                              size: 2,
                              color: context.primaryContainer.withAlpha(50),

                              duration: const Duration(milliseconds: 500),
                            ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  minimum: EdgeInsets.all(context.padding),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton.filled(
                      style: context.iconButtonStyle,

                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                PatientScreen(patient: widget.patient),
                          ),
                        );
                      },
                      icon: Icon(Icons.person, color: context.primaryContainer),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => CustomErrorWidget(
          ref: ref,
          error: error,
          onPressed: () {
            ref.invalidate(doctorsProvider);
          },
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
      ),
    );
  }
}
