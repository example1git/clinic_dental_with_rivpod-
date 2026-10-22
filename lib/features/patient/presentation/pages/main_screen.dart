import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/pages/patient_screen.dart';
import 'package:mysen/features/patient/presentation/widgets/card_doctor.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainScreen extends ConsumerStatefulWidget {
  const new({super.key, required this.patient});
  final Patient patient;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  late PageController doctorsPageController;
  late PageController pageControllerCard;
  late AnimationController animationController;
  StreamSubscription<bool>? subscription;
  late final RealtimeChannel channel;

  int currentpage = 0;
  final List<RequestReservation> requests = [];

  void handleRequestState(StateRequest state) {
    if (state == StateRequest.waiting) {
      if (!animationController.isAnimating) {
        animationController.repeat(reverse: true);
      }
    } else {
      if (animationController.isAnimating) {
        animationController.stop();
      }
    }
  }

  void setRequest() async {
    final r = await ref.read(requestReservationProvider.future);
    requests.addAll(r);
  }

  Future<void> getNotifications(List<Doctor> doctors) async {
    final localNotificationService = ref.read(localNotificationServiceProvider);
    await localNotificationService.cancelAll();

    final now = DateTime.now();
    final requestsCheck = requests.where(
      (p0) =>
          p0.stateRequest == StateRequest.accepted ||
          p0.stateRequest == StateRequest.completed,
    );

    for (final r in requestsCheck) {
      if (r.reciveTime == null) continue;
      if (r.reciveTime!.isBefore(now)) continue; // تجاهل المنتهية

      // print('✅ تم جدولة الإشعارات موعدًا');

      final doctor = doctors.firstWhere((d) => d.id == r.doctorID);

      await localNotificationService.scheduleAppointmentReminder(
        appointmentTime: r.reciveTime!,
        doctorName: doctor.fullName,
      );
    }
  }

  Future<void> changeStateRequest() async {
    // if (!await internetService.checkNow()) {
    //   return;
    // }

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

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 5,
      duration: const Duration(seconds: 1),
    );
    subscription = ref
        .read(internetServiceProvider)
        .onStatusChange
        .distinct()
        .listen((hasInternet) {
          if (hasInternet) {
            changeStateRequest();
          } else {
            // loadRequestFromSql();
          }
        });

    channel = Utils.setupRealtimeChannel(
      tableName: 'requestreservation',

      onInsert: (payload) async {
        ref.refresh(requestReservationProvider);
      },

      onUpdate: (payload) async {
        ref.refresh(requestReservationProvider);
      },
    );
  }

  @override
  void dispose() {
    doctorsPageController.dispose();
    pageControllerCard.dispose();
    animationController.stop();
    animationController.dispose();
    client.removeChannel(channel);

    // internetService.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getdoctorsProvider = ref.watch(doctorsProvider);
    return Scaffold(
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
                    onPageChanged: (value) {
                      final doctor = data[value];
                      final request = requests
                          .where((r) => r.doctorID == doctor.id)
                          .firstOrNull;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        handleRequestState(
                          request?.stateRequest ?? StateRequest.none,
                        );
                      });
                    },
                    controller: pageControllerCard,
                    children: [
                      ...List.generate(
                        data.length,
                        (index) =>
                            CardDoctor(
                              doctor: data[index],
                              requests: requests,
                              animationController: animationController,
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
        error: (error, stackTrace) =>
            CustomErrorWidget(ref: ref, error: error, onPressed: () {}),
        loading: () => Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
      ),
    );
  }
}
