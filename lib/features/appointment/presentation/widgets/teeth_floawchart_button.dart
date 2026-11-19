import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/description_flowchart_list.dart';
import 'package:mysen/features/appointment/presentation/widgets/widget_teeth_flowchart.dart';
import 'package:teeth_selector/teeth_selector.dart';

class TeethFlowchart extends StatelessWidget {
  const TeethFlowchart({
    super.key,
    required this.isButtonAddTeeth,
    this.ignoring = true,
    required this.isWidgetTeeth,
    required this.teethSelected,
  });

  final bool isButtonAddTeeth;
  final bool isWidgetTeeth;
  final List<Map> teethSelected;
  final bool ignoring;

  void onChangeSelectTeeth(
    List<String> teethSelect,
    WidgetRef ref,
    BuildContext context,
  ) {
    final teethAdd = ref.read(teehtProvider);
    final teethAddNotfire = ref.read(teehtProvider.notifier);
    for (var number in teethSelect) {
      final isExist = teethAdd.any((element) => element['number'] == number);
      if (!isExist) {
        teethAddNotfire.setTeeh({
          'number': number,
          "description": context.tr.empty,
        });
      }
    }
    teethAddNotfire.removTeeh(teethSelect);
  }

  List<String> initiallySelectedTeeth(WidgetRef ref) {
    final teethAdd = ref.read(teehtProvider);
    final List<String> number = teethAdd
        .map((element) => element['number'] as String)
        .toList();
    return number;
  }

  Map<String, Color> colorized(List<Map>? teeth) {
    final Map<String, Color> map = {};
    if (teeth == null) {
      return {};
    }
    for (var t in teeth) {
      map.addAll({t['number']: whitecolor});
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.mediaSize.shortestSide * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Closed(),
                Consumer(
                  builder: (context, ref, child) => IconButton(
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
                                Text(
                                  context.tr.description,
                                  style: context.titleLarge,
                                ),
                                const Closed(),
                              ],
                            ),
                            DescriptionFlowchartList(
                              isNumber: true,
                              teethSelected: teethSelected,
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.description_sharp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  ignoring: ignoring,
                  child: FractionallySizedBox(
                    widthFactor: .9,
                    heightFactor: .9,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return TeethSelector(
                          initiallySelected: initiallySelectedTeeth(ref),
                          textStyle: context.bodyLarge?.copyWith(
                            color: context.primaryContainer,
                          ),
                          rightString: '',
                          leftString: '',
                          unselectedColor: context.primaryContainer.withAlpha(
                            150,
                          ),

                          colorized: colorized(teethSelected),
                          selectedColor: whitecolor,
                          showPermanent: true,

                          multiSelect: true,
                          onChange: (selected) =>
                              onChangeSelectTeeth(selected, ref, context),
                        );
                      },
                    ),
                  ),
                ),

                Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: FractionallySizedBox(
                      widthFactor: context.mediaSize.width > 1300 ? 0.3 : .7,
                      heightFactor: .3,
                      child: Row(
                        spacing: context.mediaSize.shortestSide * .01,
                        children: [
                          SizedBox(width: context.mediaSize.shortestSide * .01),
                          Text(context.tr.right, style: context.bodyMeduim),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: context.primaryContainer,
                            ),
                          ),
                          Text(context.tr.left, style: context.bodyMeduim),
                          SizedBox(width: context.mediaSize.shortestSide * .01),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isWidgetTeeth ? WidgetTeethFlowChart() : const SizedBox.shrink(),

          isButtonAddTeeth
              ? Center(
                  child: FractionallySizedBox(
                    widthFactor: .9,
                    child: OutlinedButton(
                      style: context.outlinedButtonStyle,
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        context.tr.addTeeth,
                        style: context.bodyMeduim,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
