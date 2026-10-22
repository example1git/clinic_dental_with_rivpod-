import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/widgets/doctor_eqalitification.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';
import 'package:ntp/ntp.dart';

class CardDoctor extends StatefulWidget {
  const CardDoctor({
    super.key,
    required this.doctor,
    required this.requests,
    required this.patient,
    required this.animationController,
  });

  final Doctor doctor;
  final Patient patient;
  final List<RequestReservation> requests;
  final AnimationController animationController;

  @override
  State<CardDoctor> createState() => _CardDoctorState();
}

class _CardDoctorState extends State<CardDoctor> {
  Color getColor(StateRequest state, BuildContext context) {
    switch (state) {
      case StateRequest.waiting:
        return Colors.orange;
      case StateRequest.completed:
        return context.primaryContainer;
      case StateRequest.reject:
        return const Color.fromARGB(255, 235, 25, 10);
      case StateRequest.none:
        return context.primarycolor;
      case StateRequest.accepted:
        return context.primaryContainer;
    }
  }

  void handleRequestState(StateRequest state) {
    if (state == StateRequest.waiting) {
      if (!widget.animationController.isAnimating) {
        widget.animationController.repeat(reverse: true);
      }
    } else {
      if (widget.animationController.isAnimating) {
        widget.animationController.stop();
      }
    }
  }

  double getWidthBorder(StateRequest state) {
    if (widget.animationController.isAnimating) {
      return widget.animationController.value;
    } else {
      if (state == StateRequest.none) {
        return widget.animationController.lowerBound;
      } else {
        return widget.animationController.upperBound;
      }
    }
  }

  void addResqustReserv(WidgetRef ref) async {
    final reservation = RequestReservation(
      doctorID: widget.doctor.id,
      patientID: widget.patient.id,
      patientName: widget.patient.fullName,
      sendTime: await NTP.now(),
      stateRequest: StateRequest.waiting,
      phone: widget.patient.phone,
      id: '',
    );

    if (widget.requests.any((p0) => p0.stateRequest == StateRequest.waiting)) {
      // MessageHandle.handleMessage(MessageType.requestWaiting);

      return;
    }
    final request = widget.requests
        .where((element) => element.doctorID == widget.doctor.id)
        .firstOrNull;

    if (request != null &&
        (request.stateRequest == StateRequest.completed ||
            request.stateRequest == StateRequest.accepted)) {
      // MessageHandle.handleMessage(MessageType.requestComplete);

      return;
    }

    ref
        .read(requestReservationProvider.notifier)
        .upsertRequestReservation(reservation);
  }

  Future<void> updateRequestToNon(WidgetRef ref) async {
    // if (!await internetService.checkNow()) {
    //   ErrorHndel.handleError(ErrorType.internet);

    //   return;
    // }
    final request = widget.requests
        .where((element) => element.doctorID == widget.doctor.id)
        .firstOrNull;

    if (request == null) {
      // ErrorHndel.handleError(ErrorType.error);

      return;
    }
    ref
        .read(requestReservationProvider.notifier)
        .updateRequestReservation(
          request.copyWith(stateRequest: StateRequest.none),
        );
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.requests
        .where((r) => r.doctorID == widget.doctor.id)
        .firstOrNull;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleRequestState(request?.stateRequest ?? StateRequest.none);
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) => FractionallySizedBox(
        widthFactor: .8,
        heightFactor: .5,
        child: Container(
          padding: EdgeInsets.only(bottom: context.padding),
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.raduis),
            border: Border.all(
              color: getColor(
                request?.stateRequest ?? StateRequest.none,
                context,
              ),

              width: getWidthBorder(request?.stateRequest ?? StateRequest.none),
            ),
            color: context.primarycolor,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -constraints.maxHeight * .2,
                  height: constraints.maxHeight * .8,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child:
                        widget.doctor.imgUrl == null ||
                            widget.doctor.imgUrl == ''
                        ? FittedBox(
                            child: Icon(
                              Icons.person,
                              color: context.primaryContainer,
                            ),
                          )
                        : CachedNetworkImage(
                                imageUrl: widget.doctor.imgUrl ?? '',

                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                errorWidget: (context, url, error) => FittedBox(
                                  child: Icon(
                                    Icons.person,
                                    color: context.primaryContainer,
                                  ),
                                ),
                              )
                              .animate()
                              .scale(
                                duration: const Duration(milliseconds: 800),
                              )
                              .fade(
                                duration: const Duration(milliseconds: 800),
                              ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  height: constraints.maxHeight * .4,
                  width: constraints.maxWidth,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.doctor.gender == Gender.male
                            ? context.tr.doctorMale
                            : context.tr.doctorFemale,
                        style: context.bodyLarge?.copyWith(
                          color: context.primaryContainer,
                        ),
                      ),
                      Text(
                        "${widget.doctor.fullName.split(' ').sublist(0, 2).join(' ')} ${widget.doctor.fullName.split(' ').last} ",

                        style: context.bodyLarge,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: context.spacing,
                        children: [
                          ExpandIcon(
                            size: context.iconSize,
                            color: context.primaryContainer,
                            onPressed: (value) {
                              Utils.showMyDialog(
                                widthFactor: 1,
                                heightFactor: 1,

                                context: context,
                                child: DoctorEqualityfications(
                                  doctor: widget.doctor,
                                ),
                              );
                            },
                          ),
                          !widget.doctor.isWorking
                              ? Text(
                                  context.tr.holiday,
                                  style: context.bodyLarge,
                                )
                              : OutlinedButton(
                                  style: context.outlinedButtonStyle?.copyWith(
                                    minimumSize: WidgetStatePropertyAll(
                                      Size(
                                        constraints.maxWidth * .4,
                                        constraints.maxWidth * .11,
                                      ),
                                    ),
                                  ),

                                  onPressed: () {
                                    Utils.showMyDialog(
                                      dismissible: true,

                                      heightFactor: .3,
                                      widthFactor: .8,

                                      colorDialog: context.primarycolor,
                                      context: context,
                                      child: Consumer(
                                        builder: (context, ref, child) => Alert(
                                          title:
                                              request?.stateRequest ==
                                                  StateRequest.waiting
                                              ? context.tr.titleRequestCancel
                                              : context.tr.titleRequest,
                                          confirme: () {
                                            request?.stateRequest ==
                                                    StateRequest.waiting
                                                ? updateRequestToNon(ref)
                                                : addResqustReserv(ref);
                                          },
                                          isLoading: false,
                                        ),
                                      ),
                                    );
                                  },

                                  child: Text(
                                    request?.stateRequest ==
                                            StateRequest.waiting
                                        ? context.tr.cancelRequest
                                        : context.tr.requestTitle,
                                    style: context.bodyMeduim,
                                  ),
                                ),
                        ],
                      ),

                      Directionality(
                        textDirection:
                            // Get.locale?.languageCode == 'ar'
                            //     ? ui.TextDirection.ltr
                            //     :
                            ui.TextDirection.rtl,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              textAlign: TextAlign.center,

                              request?.reciveTime == null
                                  ? context.tr.noAppointment
                                  : DateFormat('yyyy-MM-dd hh:mm a')
                                        .format(request!.reciveTime!),
                              textDirection: ui.TextDirection.ltr,
                              style: context.textAppointment,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              context.tr.appointmentTime,
                              style: context.bodyMeduim,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
