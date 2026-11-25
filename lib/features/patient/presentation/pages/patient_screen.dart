import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/core/widget/card_drawer.dart';
import 'package:mysen/core/widget/my_drawer.dart';
import 'package:mysen/core/widget/theme_widget.dart';
import 'package:mysen/core/widget_language.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/widgets/body_patient.dart';
import 'package:mysen/features/patient/presentation/widgets/row_profile.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        children: [
          CardDrawer(
            title: context.tr.doctorProfile,
            onTap: () {
              Utils.showMyDialog(
                dismissible: true,

                widthFactor: .8,

                heightFactor: .3,
                colorDialog: context.primarycolor.withAlpha(200),

                context: context,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RowProfile(title: patient.fullName, icon: Icons.person),
                    RowProfile(title: patient.phone, icon: Icons.phone_android),
                  ],
                ),
              );
            },
            iconData: Icons.person,
          ),
          CardDrawer(
            title: context.tr.theme,
            onTap: () {
              Utils.showMyDialog(
                heightFactor: .5,

                context: context,
                child: const ThemeWidget(),
              );
            },
            iconData: Icons.color_lens,
          ),

          CardDrawer(
            title: context.tr.language,
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
            iconData: Icons.language_outlined,
          ),
        ],
      ),

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.primaryContainer,
          size: context.iconSize,
        ),

        leadingWidth: context.mediaSize.shortestSide * .15,

        toolbarHeight: context.mediaSize.shortestSide * .15,

        backgroundColor: context.primarycolor,

        actions: const [Backed(leftDirction: true)],
        title: FittedBox(
          child: Text(context.tr.doctorList, style: context.titleLarge),
        ),
        centerTitle: true,
      ),
      body: const BodyPatient(),
    );
  }
}
