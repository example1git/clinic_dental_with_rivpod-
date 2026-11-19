import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class DoctorEditEqu extends StatefulWidget {
  const DoctorEditEqu({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<DoctorEditEqu> createState() => _DoctorEditEquState();
}

class _DoctorEditEquState extends State<DoctorEditEqu> {
  late TextEditingController equlatificationsController;
  GlobalKey<FormState> formKeyEq = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    equlatificationsController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    equlatificationsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.mediaSize.shortestSide * .02),
      child: Column(
        spacing: context.mediaSize.shortestSide * .05,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Closed(),
              Text(context.tr.editQualifications, style: context.titleLarge),
            ],
          ),
          Form(
            key: formKeyEq,
            child: Row(
              children: [
                Expanded(
                  child: MytexFormFiled(
                    filled: false,
                    controller: equlatificationsController,
                    label: context.tr.equalzation,
                    validate: Validate.equalization,
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) => IconButton(
                    style: context.iconButtonStyle,
                    onPressed: () {
                      if (!formKeyEq.currentState!.validate()) {
                        return;
                      }
                      ref
                          .read(equlatificationsProvider.notifier)
                          .addEqulatifications(
                            equlatificationsController.text.trim(),
                          );
                      equlatificationsController.clear();
                    },
                    icon: Icon(
                      size: context.iconSize,
                      Icons.add,
                      color: whitecolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final eq = ref.watch(equlatificationsProvider);
                return ListView.builder(
                  itemCount: eq.length,

                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: IconButton(
                        style: context.iconButtonStyle,
                        onPressed: () {
                          ref
                              .read(equlatificationsProvider.notifier)
                              .removeEqulatifications(eq[index]);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      leading: Icon(
                        Icons.star,
                        size: context.iconSize,
                        color: context.primaryContainer,
                      ),

                      title: Text(style: context.bodyMeduim, eq[index]),
                    );
                  },
                );
              },
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: .8,
              child: Consumer(
                builder: (context, ref, child) => OutlinedButton(
                  style: context.outlinedButtonStyle,
                  onPressed: () {
                    final eq = ref.watch(equlatificationsProvider);
                    final doctor = widget.doctor.copyWith(equlatifications: eq);
                    ref.read(doctorProvider.notifier).updateDoctor(doctor);
                    context.pop();
                  },
                  child: Text(context.tr.done, style: context.bodyMeduim),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
