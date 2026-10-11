import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:teeth_selector/teeth_selector.dart';

class TeethFlowchart extends StatelessWidget {
  const TeethFlowchart({
    super.key,
    required this.isButtonAddTeeth,
    this.ignoring = true,
    required this.colorized,
    required this.widgetTeethButton,
    this.onPressedAdd,
    required this.initiallySelected,
    this.widgetDescription,
  });

  final bool isButtonAddTeeth;
  final Widget? widgetTeethButton;
  final Widget? widgetDescription;
  final bool ignoring;
  final List<String> initiallySelected;
  final Map<String, Color> colorized;
  final void Function()? onPressedAdd;
  void onChangeSelectTeeth(List<String> teethSelect) {
    for (var number in teethSelect) {
      final isExist = teethAdd.any((element) => element['number'] == number);
      if (!isExist) {
        teethAdd.add({'number': number, "description": 'empty'.tr});
      }
    }
    teethAdd.removeWhere((element) => !teethSelect.contains(element['number']));
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
                widgetDescription ?? const SizedBox.shrink(),
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
                    child: TeethSelector(
                      initiallySelected: initiallySelected,
                      textStyle: context.bodyLarge?.copyWith(
                        color: context.primaryContainer,
                      ),
                      rightString: '',
                      leftString: '',
                      unselectedColor: context.primaryContainer.withAlpha(150),

                      colorized: colorized,
                      selectedColor: whitecolor,
                      showPermanent: true,

                      multiSelect: true,
                      onChange: onChangeSelectTeeth,
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
          widgetTeethButton ?? const SizedBox.shrink(),

          isButtonAddTeeth
              ? Center(
                  child: FractionallySizedBox(
                    widthFactor: .9,
                    child: OutlinedButton(
                      style: context.outlinedButtonStyle,
                      onPressed: onPressedAdd,
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
