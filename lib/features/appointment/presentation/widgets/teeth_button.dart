import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/appointment/presentation/widgets/description_button.dart';
import 'package:mysen/features/appointment/presentation/widgets/teeth_floawchart_button.dart';
import 'package:mysen/features/appointment/presentation/widgets/widget_teeth_flowchart.dart';

class TeethButton extends StatelessWidget {
  const TeethButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Utils.showMyDialog(
          context: context,
          child: TeethFlowchart(
            widgetDescription: IconButton(
              style: context.iconButtonStyle,
              onPressed: () {
                Utils.showMyDialog(
                  context: context,
                  child: Column(
                    spacing: context.mediaSize.shortestSide * .02,
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          const Closed(),
                          Text(
                            context.tr.description,
                            style: context.titleLarge,
                          ),
                        ],
                      ),

                      DescriptionsButton(),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.description_sharp),
            ),
            ignoring: false,
            isButtonAddTeeth: true,

            widgetTeethButton: WidgetTeethFlowChart(),
            onPressedAdd: () {
              // appointmentController.addTeethAdd();
            },
          ),
        );
      },
      icon: FaIcon(
        size: context.mediaSize.shortestSide * .045,
        FontAwesomeIcons.tooth,
        color: context.primaryContainer,
      ),
    );
  }
}
