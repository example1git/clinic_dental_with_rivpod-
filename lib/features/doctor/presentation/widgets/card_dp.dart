import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class CardPatient extends StatelessWidget {
  const CardPatient({
    super.key,
    required this.trailing,

    required this.title,
    required this.leading,
    this.imageUrl,
  });

  final Widget title;
  final Widget leading;
  final Widget? trailing;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.padding / 2),
      child: Row(
        children: [
          imageUrl == null
              ? const SizedBox.shrink()
              : CircleAvatar(
                  radius: context.raduis * 3,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl ?? '',

                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
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
                  ),
                ),

          Expanded(
            child: Card(
              color: context.primarycolor,
              shadowColor: blackcolor,
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(context.padding),
                child: Row(
                  children: [
                    leading,
                    Expanded(child: title),
                    trailing ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
