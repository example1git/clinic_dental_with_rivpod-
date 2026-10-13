import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/my_form_textfiled.dart';

import 'dart:ui' as ui;

import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
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
  int totoal = 0;
  int payPaid = 0;
  int remaining = 0;

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
    setPrice();
  }

  void setPrice() {
    totoal = widget.treatmentCase.totalPrice;
    payPaid = ref.watch(payPaidProvider);
    remaining = totoal - payPaid;
    setState(() {});
  }

  void setRemainingPric(int total, int payPaid) {
    if (payPriceController.text.isNotEmpty) {
      remaining = 0;
      remaining = (total - payPaid - int.parse(payPriceController.text));
    } else {
      remaining = (total - payPaid);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appointmentDateNotfir = ref.read(appointmentDateProvider.notifier);
    final getAppointmentDateProvider = ref.read(appointmentDateProvider);
    final teeth = ref.watch(teehtProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: context.primarycolor,
        appBar: AppBar(
          toolbarHeight: context.mediaSize.shortestSide * .15,
          leadingWidth: context.mediaSize.shortestSide * .15,
          leading: const Backed(),
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

                RowPrice(price: totoal, title: "${context.tr.totalPrice}:"),
                RowPrice(
                  price: payPaid,
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
                            setRemainingPric(totoal, payPaid);
                          },
                          controller: payPriceController,
                          label: '',
                        ),
                      ),
                    ),
                  ],
                ),

                RowPrice(
                  price: remaining,
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
                        teethSelected: teeth,
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
