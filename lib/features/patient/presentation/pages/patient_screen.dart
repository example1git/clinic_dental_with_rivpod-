import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class PatientScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primarycolor,

      body: Center(
        child: Consumer(
          builder: (context, ref, child) => ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              // ref.read(authProvider)si();
            },
            child: Text('patient'),
          ),
        ),
      ),
    );
  }
}
