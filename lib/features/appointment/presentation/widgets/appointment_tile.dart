import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_table.dart';
import 'package:mysen/features/appointment/presentation/widgets/teeth_floawchart_button.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    super.key,
    required this.title,
    required this.index,
    required this.colorized,
    required this.isButtonAddTeeth,
    this.widgetTeethButton,
    this.widgetDescription,
    required this.totalPrice,
    required this.prevoiuspaid,
    required this.payPrice,
  });

  final String title;
  final int totalPrice;
  final int prevoiuspaid;
  final int payPrice;

  final int index;
  final Map<String, Color> colorized;
  final bool isButtonAddTeeth;
  final Widget? widgetTeethButton;
  final Widget? widgetDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.padding),
      child: ExpansionTile(
        trailing: Icon(Icons.expand_more, size: context.iconSize),

        iconColor: whitecolor,
        collapsedIconColor: context.primaryContainer,
        leading: IconButton(
          iconSize: context.iconSize,
          onPressed: () {
            Utils.showMyDialog(
              context: context,
              child: TeethFlowchart(
                widgetDescription: widgetDescription,
                isButtonAddTeeth: isButtonAddTeeth,

                widgetTeethButton: widgetTeethButton,
              ),
            );
          },
          icon: const FaIcon(FontAwesomeIcons.tooth),
        ),

        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.raduis),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.raduis),
        ),

        collapsedBackgroundColor: context.primaryContainer.withAlpha(50),
        backgroundColor: context.primaryContainer.withAlpha(10),

        title: Column(
          children: [
            Text(context.tr.appointmentTime, style: context.bodyMeduim),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                title,
                style: context.bodyMeduim,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        children: [
          AppointmentTable(
            title: context.tr.totalPrice,
            traling: totalPrice.toString(),
          ),
          AppointmentTable(
            title: context.tr.previouslyPaid,
            traling: index == 0 ? '0' : "$prevoiuspaid",
          ),
          AppointmentTable(
            title: context.tr.paidAmount,
            traling: payPrice.toString(),
          ),
          AppointmentTable(
            title: context.tr.remainingPrice,
            traling: "${totalPrice - prevoiuspaid - payPrice}",
          ),
        ],
      ),
    );
  }
}
