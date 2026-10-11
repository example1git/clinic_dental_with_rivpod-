import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/widgets/doctor_edit_details.dart';
import 'package:mysen/features/doctor/presentation/widgets/state_working.dart';

class CardDoctorEditing extends StatelessWidget {
  const CardDoctorEditing({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: context.padding),
        decoration: BoxDecoration(
          color: context.primarycolor,

          borderRadius: BorderRadius.circular(context.raduis),
        ),
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .5,
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  height: constraints.maxHeight * .35,
                  width: constraints.maxWidth * .8,
                  bottom: 0,
                  child: DoctorEditDetails(doctor: doctor),
                ),
                Positioned(
                  height: constraints.maxHeight * .8,
                  top: -constraints.maxHeight * .2,

                  child: doctor.imgUrl == null
                      ? FittedBox(
                          child: Icon(
                            Icons.person,
                            color: context.primaryContainer,
                          ),
                        )
                      : CachedNetworkImage(
                              imageUrl: doctor.imgUrl!,

                              placeholderFadeInDuration: const Duration(
                                seconds: 1,
                              ),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                              errorWidget: (context, url, error) => FittedBox(
                                child: Icon(
                                  Icons.person,
                                  color: context.primaryContainer,
                                ),
                              ),
                            )
                            .animate()
                            .scale(duration: const Duration(milliseconds: 500))
                            .fade(duration: const Duration(milliseconds: 800)),
                ),
                const Align(alignment: Alignment.topLeft, child: Backed()),

                StateWorking(doctor: doctor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
