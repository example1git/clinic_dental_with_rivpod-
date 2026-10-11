import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'dart:ui' as ui;
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/controller/appointment_controller.dart';
import 'package:mysen/features/doctor/widget/RowPrice.dart';
import 'package:mysen/features/doctor/widget/teeth_button.dart';
import 'package:mysen/features/shared/model/treatment_case.dart';
import 'package:mysen/features/shared/widget/backed.dart';
import 'package:mysen/features/shared/widget/my_form_textfiled.dart';

class AppointmetDialog extends StatelessWidget {
  const AppointmetDialog({
    super.key,
    required this.treatmentCase,
    required this.appointmentController,
  });
  final TreatmentCase treatmentCase;
  final AppointmentController appointmentController;
  @override
  Widget build(BuildContext context) {
    final int totalPrice = treatmentCase.totalPrice;
    final int payPaid = appointmentController.payPaid(treatmentCase);
    final remainingPrice = (totalPrice - payPaid);

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
            'Add apointmentn'.tr,
            style: context.titleLarge?.copyWith(color: whitecolor),
          ),
          centerTitle: true,
          backgroundColor: context.primarycolor,
        ),

        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.all(context.padding),
          child: Form(
            key: appointmentController.formKeyAppointment,
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
                          appointmentController.setTime(timeappintemt);
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
                          appointmentController.setDate(dateappintemt);
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text("${'date'.tr}   :", style: context.textAppointment),
                    Obx(
                      () => Text(
                        textDirection: ui.TextDirection.ltr,
                        DateFormat('yyyy-MM-dd hh:mm a').format(
                          appointmentController.dateTimeAppointemnt.value,
                        ),
                        style: context.textAppointment,
                      ),
                    ),
                  ],
                ),

                RowPrice(price: totalPrice, title: "${'total price'.tr}:"),
                RowPrice(price: payPaid, title: "${'previouslyPaid'.tr} :"),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        "currentPaid".tr,
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
                            appointmentController.setRemainingPric(
                              totalPrice,
                              payPaid,
                            );
                          },
                          controller: appointmentController.payPrice,
                          label: '',
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => RowPrice(
                    price: appointmentController.remainingPrice.value == 0
                        ? remainingPrice
                        : appointmentController.remainingPrice.value,
                    title: "${'remaining price'.tr} :",
                  ),
                ),

                TeethButton(appointmentController: appointmentController),

                FractionallySizedBox(
                  widthFactor: .8,
                  child: Obx(
                    () =>
                        OutlinedButton(
                          style: context.outlinedButtonStyle,
                          onPressed: () {
                            appointmentController.addAppointment(
                              treatmentCase.id,
                            );
                          },
                          child: Text("done".tr, style: context.bodyMeduim),
                        ).loading(
                          appointmentController.isLoading.value,
                          context.primaryContainer,
                        ),
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
