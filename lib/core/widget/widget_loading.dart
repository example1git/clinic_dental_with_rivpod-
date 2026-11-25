import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WidgetLoading extends StatelessWidget {
  const new({super.key, required this.loading, required this.circleWidget});
  final bool loading;
  final bool circleWidget;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enableSwitchAnimation: true,
      enabled: loading,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 15,
        itemBuilder: (context, index) => Row(
          children: [
            if (circleWidget) Bone.circle(size: context.mediaSize.width * .15),

            Expanded(
              child: Card(
                child: ListTile(
                  leading: Bone.button(width: 20, uniRadius: context.raduis),
                  title: const Bone.text(words: 10),
                  trailing: Bone.button(width: 20, uniRadius: context.raduis),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
