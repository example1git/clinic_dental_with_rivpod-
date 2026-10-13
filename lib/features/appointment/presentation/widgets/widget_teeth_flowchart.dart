import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';

class WidgetTeethFlowChart extends ConsumerStatefulWidget {
  const WidgetTeethFlowChart({super.key});

  @override
  ConsumerState<WidgetTeethFlowChart> createState() =>
      _WidgetTeethFlowChartState();
}

class _WidgetTeethFlowChartState extends ConsumerState<WidgetTeethFlowChart> {
  late TextEditingController descruptionController;

  @override
  void initState() {
    super.initState();
    descruptionController = TextEditingController();
  }

  @override
  void dispose() {
    descruptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teethAdd = ref.watch(teehtProvider);
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: teethAdd.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Utils.showMyDialog(
                widthFactor: .9,
                heightFactor: .9,
                context: context,
                child: Column(
                  spacing: context.spacing,

                  children: [
                    Row(
                      children: [
                        const Closed(),
                        Expanded(
                          child: Center(
                            child: Text(
                              context.tr.addDescription,
                              style: context.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: context.mediaSize.shortestSide * .05,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MytexFormFiled(
                              filled: false,
                              controller: descruptionController,
                              label: "🦷${teethAdd[index]['number']}",
                              validate: Validate.none,
                            ),

                            Text(
                              style: context.bodyMeduim,
                              teethAdd[index]['description'],
                            ),

                            Center(
                              child: FractionallySizedBox(
                                widthFactor: .8,
                                child: OutlinedButton(
                                  style: context.outlinedButtonStyle,
                                  onPressed: () {
                                    addDescription(teethAdd[index], ref);
                                    context.pop();
                                  },
                                  child: Text(
                                    context.tr.done,
                                    style: context.bodyMeduim,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Card(
              color: context.primarycolor.withAlpha(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    size: context.iconSize,
                    FontAwesomeIcons.tooth,
                    color: whitecolor,
                  ),
                  Text(teethAdd[index]['number'], style: context.bodyMeduim),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void addDescription(Map teethAdd, WidgetRef ref) {
    if (descruptionController.text.isNotEmpty) {
      final map = teethAdd;
      teethAdd['description'] = descruptionController.text;
      ref.read(teehtProvider.notifier).updateTeeh(map);
      descruptionController.clear();
    }
  }
}
