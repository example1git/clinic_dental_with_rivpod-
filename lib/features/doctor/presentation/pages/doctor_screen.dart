import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/body_doctor.dart';
import 'package:mysen/features/doctor/presentation/widgets/bottomnavgiationbar_doctor.dart';
import 'package:mysen/features/doctor/presentation/widgets/drawer_doctor.dart';

class DoctorScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(doctorProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: doctor.when(
        data: (data) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     // print(await DatabaseHelper.instance.queryAll('doctorPatient'));
            //     // await DatabaseHelper.instance.deleteDatabaseFile();
            //   },
            // ),
            backgroundColor: context.primarycolor,
            bottomNavigationBar: BottomNavgiationBarDoctor(),

            drawer: DrawerDoctor(),

            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context.primaryContainer,
                size: context.iconSize,
              ),
              leadingWidth: context.mediaSize.shortestSide * .15,

              toolbarHeight: context.mediaSize.shortestSide * .15,
              centerTitle: true,

              backgroundColor: context.primarycolor,

              title: FittedBox(
                child: Text(
                  textAlign: TextAlign.center,
                  data?.fullName ?? '',
                  style: context.titleLarge,
                ),
              ),
            ),

            body: BodyDoctor(),
          );
        },
        error: (error, stackTrace) {
          return CustomErrorWidget(
            ref: ref,
            error: error,
            onPressed: () {
              ref.invalidate(doctorProvider);
            },
          );
        },
        loading: () {
          return Container(
            color: context.primarycolor,
            child: Center(
              child: CircularProgressIndicator(color: context.primaryContainer),
            ),
          );
        },
      ),
    );
  }
}
