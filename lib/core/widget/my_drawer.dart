import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/card_drawer.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: blackcolor,
      width: context.mediaSize.width * .7,
      backgroundColor: context.primarycolor,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(child: Text('My Sen', style: context.titleLarge)),
          ),
          Expanded(flex: 5, child: Column(children: children)),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) => CardDrawer(
                title: context.tr.signOut,
                iconData: Icons.logout,
                onTap: () {
                  ref.read(authProvider.notifier).signOut();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
