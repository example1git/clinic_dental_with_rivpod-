import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/provider/theme_provider.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.mediaSize.shortestSide * .05,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const Backed(),

            Center(child: Text(context.tr.setTheme, style: context.titleLarge)),
          ],
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: Utils.listTheme.length,
            itemBuilder: (BuildContext context, int index) {
              final Color primary = Utils.listTheme[index]['primary'];
              final Color primaryContainer =
                  Utils.listTheme[index]['primaryContainer'];

              return Consumer(
                builder: (context, ref, child) => InkWell(
                  onTap: () {
                    final name = Utils.listTheme[index]['name'];
                    FlexScheme? flexSchema = Utils.flexschema.firstWhere(
                      (element) => element.name == name,
                    );

                    ref.read(themeProvider.notifier).changeTheme(flexSchema);
                    context.pop();
                  },
                  child: Transform.scale(
                    scale: .5,
                    child: Card(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: ColoredBox(
                              color: primary,

                              child: const SizedBox.expand(),
                            ),
                          ),
                          Expanded(
                            child: ColoredBox(
                              color: primaryContainer,

                              child: const SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
