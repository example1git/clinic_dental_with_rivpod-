import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/card_doctor_editing.dart';

class DoctorProfile extends ConsumerWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refDoctor = ref.watch(doctorProvider);
    return Scaffold(
      backgroundColor: context.primarycolor,
      resizeToAvoidBottomInset: false,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: refDoctor.when(
          data: (data) {
            final imgurl = data?.imgUrl;
            final doctor = data;

            return data == null
                ? const SizedBox.shrink()
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      doctor?.isWorking ?? true
                          ? Colors.transparent
                          : context.primaryContainer,
                      BlendMode.color,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: imgurl == null
                              ? const FittedBox(child: Icon(Icons.person))
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: imgurl,

                                  placeholderFadeInDuration: const Duration(
                                    seconds: 1,
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          value: progress.progress,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      const FittedBox(
                                        child: Icon(Icons.person),
                                      ),
                                ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(color: blackcolor.withAlpha(100)),
                          ),
                        ),
                        CardDoctorEditing(doctor: data),
                      ],
                    ),
                  );
          },
          error: (error, stackTrace) {
            return CustomErrorWidget(
              error: error,
              onPressed: () {
                ref.invalidate(doctorProvider);
              },
              isScaffold: true,
            );
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(color: context.primaryContainer),
            );
          },
        ),
      ),
    );
  }
}
