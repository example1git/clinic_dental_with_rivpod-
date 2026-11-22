import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/body_doctor.dart';
import 'package:mysen/features/doctor/presentation/widgets/bottomnavgiationbar_doctor.dart';
import 'package:mysen/features/doctor/presentation/widgets/drawer_doctor.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends ConsumerState<DoctorScreen> {
  late final RealtimeChannel channel;

  @override
  void initState() {
    channel = Utils.setupRealtimeChannel(
      tableName: 'requestreservation',

      onInsert: (payload) async {
        ref.invalidate(requestReservationProvider);
      },

      onUpdate: (payload) async {
        ref.invalidate(requestReservationProvider);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    client.removeChannel(channel);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ref.watch(doctorProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: doctor.when(
        data: (data) {
          return Scaffold(
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
