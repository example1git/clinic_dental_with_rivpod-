import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/card_drawer.dart';
import 'package:mysen/core/widget/my_drawer.dart';
import 'package:mysen/core/widget/theme_widget.dart';
import 'package:mysen/core/widget_language.dart';

class DrawerDoctor extends StatelessWidget {
  const DrawerDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      children: [
        CardDrawer(
          title: context.tr.doctorProfile,
          iconData: Icons.person,
          onTap: () {
            context.push(AppRoutes.doctorProfile);
          },
        ),

        CardDrawer(
          title: context.tr.theme,
          iconData: Icons.color_lens,
          onTap: () {
            Utils.showMyDialog(
              heightFactor: .5,
              context: context,
              child: const ThemeWidget(),
            );
          },
        ),
        CardDrawer(
          title: context.tr.language,
          iconData: Icons.language_outlined,
          onTap: () {
            Utils.showMyDialog(
              colorDialog: context.primarycolor,
              widthFactor: .8,
              heightFactor: .3,
              dismissible: true,
              context: context,
              child: const WidgetLanguage(),
            );
          },
        ),
      ],
    );
  }
}
