import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';

class DescriptionFlowchartList extends ConsumerWidget {
  const DescriptionFlowchartList({
    super.key,
    required this.isNumber,
    required this.teethSelected,
  });

  final bool isNumber;
  final List<Map> teethSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teethprovider = ref.watch(teehtProvider);
    final teethes = teethSelected.isEmpty ? teethprovider : teethSelected;
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: context.primaryContainer),
        itemCount: teethes.length,
        itemBuilder: (BuildContext context, int index) {
          final teeth = teethes[index];
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
