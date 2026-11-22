import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.mediaSize.shortestSide * .04,
        vertical: context.mediaSize.shortestSide * .02,
      ),
      child: Consumer(
        builder: (context, ref, child) => SearchAnchor.bar(
          barLeading: Icon(Icons.search, size: context.iconSize),
          barPadding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: context.mediaSize.shortestSide * .015,
              horizontal: context.mediaSize.shortestSide * .03,
            ),
          ),
          viewHeaderTextStyle: context.bodyLarge?.copyWith(color: blackcolor),

          barTextStyle: WidgetStatePropertyAll(
            context.bodyMeduim?.copyWith(color: blackcolor),
          ),
          barHintStyle: WidgetStatePropertyAll(
            context.bodyMeduim?.copyWith(color: blackcolor),
          ),
          barHintText: context.tr.searchFieldTitle,

          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
                final query = controller.text.trim().toLowerCase();

                if (query.isEmpty) {
                  return const [];
                }
                final dp = ref.watch(doctorPatientProvider).value ?? [];
                final results = dp.where(
                  (p) => p.patientFullName.toLowerCase().contains(query),
                );

                return results.map((p) {
                  return ListTile(
                    title: Text(
                      p.patientFullName,
                      style: context.bodyMeduim?.copyWith(color: blackcolor),
                    ),
                    onTap: () {
                      controller.closeView(p.patientFullName);
                      // doctorcontroller.filterPatient(p);
                    },
                  );
                });
              },
        ),
      ),
    );
  }
}
