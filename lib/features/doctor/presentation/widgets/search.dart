import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.mediaSize.shortestSide * .04,
        vertical: context.mediaSize.shortestSide * .02,
      ),
      child: SearchAnchor.bar(
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
              final results = [];

              // final results = doctorcontroller.patientsfordoctor
              //     .where(
              //       (p) => p.fullName.toLowerCase().contains(query),
              //     );

              return results.map((p) {
                return ListTile(
                  title: Text(
                    p.fullName,
                    style: context.bodyMeduim?.copyWith(color: blackcolor),
                  ),
                  onTap: () {
                    controller.closeView(p.fullName);
                    // doctorcontroller.filterPatient(p);
                  },
                );
              });
            },
      ),
    );
  }
}
