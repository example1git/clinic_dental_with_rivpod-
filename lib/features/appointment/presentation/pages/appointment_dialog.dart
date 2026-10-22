import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/my_form_textfiled.dart';

import 'dart:ui' as ui;

import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/RowPrice.dart';
import 'package:mysen/features/appointment/presentation/widgets/teeth_floawchart_button.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class AppointmetDialog extends ConsumerStatefulWidget {
  const AppointmetDialog({
    super.key,
    required this.treatmentCase,
    required this.dp,
  });
  final TreatmentCase treatmentCase;
  final DoctorPateint dp;

  @override
  ConsumerState<AppointmetDialog> createState() => _AppointmetDialogState();
}

class _AppointmetDialogState extends ConsumerState<AppointmetDialog> {
  GlobalKey<FormState> formKeyAppointment = GlobalKey();
  late TextEditingController payPriceController;

  @override
  void initState() {
    super.initState();
    payPriceController = TextEditingController();
    setPrice();
  }

  @override
  void dispose() {
    super.dispose();
    payPriceController.dispose();
  }

  void setPrice() async {
    await ref.read(payPaidProvider.notifier).getPayPaid(widget.treatmentCase);
    final payPaid = ref.read(payPaidProvider);
    final totoal = widget.treatmentCase.totalPrice;
    final remaining = totoal - payPaid;
    await ref.read(remainingProvider.notifier).setRemaining(remaining);
  }

  void setRemainingPric() {
    final payPaid = ref.read(payPaidProvider);
    final total = widget.treatmentCase.totalPrice;
    if (payPriceController.text.isNotEmpty) {
      final remaining = (total - payPaid - int.parse(payPriceController.text));
      ref.read(remainingProvider.notifier).setRemaining(remaining);
    } else {
      final remaining = (total - payPaid);
      ref.read(remainingProvider.notifier).setRemaining(remaining);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appointmentDateNotfir = ref.read(appointmentDateProvider.notifier);
    final getAppointmentDateProvider = ref.read(appointmentDateProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: context.primarycolor,
        appBar: AppBar(
          toolbarHeight: context.mediaSize.shortestSide * .15,
          leadingWidth: context.mediaSize.shortestSide * .15,
          leading: IconButton(
            style: context.iconButtonStyle,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            context.tr.addAppointment,
            style: context.titleLarge?.copyWith(color: whitecolor),
          ),
          centerTitle: true,
          backgroundColor: context.primarycolor,
        ),

        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.all(context.padding),
          child: Form(
            key: formKeyAppointment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: context.spacing,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      style: context.iconButtonStyle,
                      onPressed: () async {
                        final timeappintemt = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute,
                          ),
                        );
                        if (timeappintemt != null) {
                          appointmentDateNotfir.setTime(timeappintemt);
                        }
                      },
                      icon: const Icon(Icons.alarm_outlined),
                    ),
                    IconButton(
                      style: context.iconButtonStyle,
                      onPressed: () async {
                        final dateappintemt = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );

                        if (dateappintemt != null) {
                          appointmentDateNotfir.setDate(dateappintemt);
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(
                      "${context.tr.date}   :",
                      style: context.textAppointment,
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      DateFormat('yyyy-MM-dd hh:mm a')
                          .format(getAppointmentDateProvider),
                      style: context.textAppointment,
                    ),
                  ],
                ),

                RowPrice(
                  price: widget.treatmentCase.totalPrice,
                  title: "${context.tr.totalPrice}:",
                ),
                RowPrice(
                  price: ref.watch(payPaidProvider),
                  title: "${context.tr.previouslyPaid} :",
                ),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        context.tr.currentPaid,
                        style: context.bodyMeduim,
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: .5,

                        child: MytexFormFiled(
                          maxLength: 6,
                          filled: false,
                          validate: Validate.price,

                          keyboardType: TextInputType.number,

                          onChanged: (p0) {
                            setRemainingPric();
                          },
                          controller: payPriceController,
                          label: '',
                        ),
                      ),
                    ),
                  ],
                ),

                RowPrice(
                  price: ref.watch(remainingProvider),
                  title: "${context.tr.remainingPrice} :",
                ),

                IconButton(
                  onPressed: () {
                    Utils.showMyDialog(
                      context: context,
                      child: TeethFlowchart(
                        ignoring: false,
                        isButtonAddTeeth: true,

                        isWidgetTeeth: true,
                        teethSelected: [],
                      ),
                    );
                  },
                  icon: FaIcon(
                    size: context.mediaSize.shortestSide * .045,
                    FontAwesomeIcons.tooth,
                    color: context.primaryContainer,
                  ),
                ),

                FractionallySizedBox(
                  widthFactor: .8,
                  child: OutlinedButton(
                    style: context.outlinedButtonStyle,
                    onPressed: () {
                      final teethSelected = ref.read(teehtProvider);
                      final appointment = Appointment(
                        timeAppointment: getAppointmentDateProvider,
                        payPrice: int.parse(payPriceController.text.trim()),
                        treatmentCaseID: widget.treatmentCase.id,
                        teethSelected: teethSelected,
                        id: '',
                        doctorPatientID: widget.dp.id,
                      );
                      ref
                          .read(appointmentProvider.notifier)
                          .addppointment(appointment);
                    },
                    child: Text(context.tr.done, style: context.bodyMeduim),
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
