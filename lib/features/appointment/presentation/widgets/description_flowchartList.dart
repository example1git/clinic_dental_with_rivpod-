import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/features/shared/model/appointment.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class DescriptionFlowchartList extends StatelessWidget {
  const DescriptionFlowchartList({
    super.key,
    required this.appointMent,
    required this.isNumber,
  });

  final Appointment appointMent;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: context.primaryContainer),
        itemCount: appointMent.teethSelected?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final teeth = appointMent.teethSelected![index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Text(teeth['description'], style: context.bodyMeduim),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      size: context.mediaSize.shortestSide * .04,
                      FontAwesomeIcons.tooth,
                      color: whitecolor,
                    ),
                    if (isNumber)
                      Text(style: context.bodyMeduim, teeth['number']),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
