import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/row_price.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class PrcieDetailes extends ConsumerWidget {
  const new({super.key, required this.treatment});

  final TreatmentCase treatment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payPrice = ref.watch(payPaidProvider);
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: IconButton(
        style: context.iconButtonStyle,
        onPressed: () {
          Utils.showMyDialog(
            dismissible: true,
            widthFactor: .9,
            heightFactor: .3,
            colorDialog: context.primarycolor.withAlpha(50),
            context: context,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RowPrice(
                  price: treatment.totalPrice,
                  title: context.tr.totalPrice,
                ),
                RowPrice(price: payPrice, title: context.tr.paidAmount),
                RowPrice(
                  price: treatment.totalPrice - payPrice,
                  title: context.tr.remainingPrice,
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.book_online),
      ),
    );
  }
}
