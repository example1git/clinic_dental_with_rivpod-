import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/card_bottom_navigation_bar.dart';
import 'package:mysen/features/doctor/presentation/widgets/form_add_patient.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';

class BottomNavgiationBarDoctor extends StatelessWidget {
  const BottomNavgiationBarDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CardBottomNavigationBar(
            iconData: Icons.add,
            onPressed: () {
              Utils.showMyDialog(
                widthFactor: context.mediaSize.width < 600 ? 1 : .9,
                heightFactor: 1,
                context: context,
                child: const FormAddpatient(),
              );
            },
          ),

          CardBottomNavigationBar(
            iconData: Icons.view_timeline_outlined,
            onPressed: () {
              context.push(AppRoutes.allreserve);
            },
          ),

          Card(
            clipBehavior: Clip.none,
            elevation: elevation,
            color: context.primaryContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final request =
                    ref.watch(requestReservationProvider).value ?? [];
                final countRequest = request
                    .where(
                      (element) => element.stateRequest == StateRequest.waiting,
                    )
                    .length
                    .toString();
                return Badge(
                  offset: Offset(context.mediaSize.shortestSide * .08, 0),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(3),
                  label: Text(countRequest, style: context.bodyMeduim),

                  backgroundColor: context.colorScheme.error,
                  child: IconButton(
                    style: context.iconButtonStyle,
                    onPressed: () {
                      context.push(AppRoutes.notifications);
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: context.primarycolor,
                    ),
                  ),
                );
              },
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              bool search = ref.watch(isSearch);
              return CardBottomNavigationBar(
                iconData: search ? Icons.search_off : Icons.search_rounded,
                onPressed: () {
                  ref.read(isSearch.notifier).state = !search;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
