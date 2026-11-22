import 'package:flutter/material.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';

class CustomErrorWidget extends StatelessWidget {
  const new({super.key, required this.error, required this.onPressed});

  final Object error;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primarycolor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 60),
            const SizedBox(height: 16),
            if (error is InternetFailure || error is RequestFocusAction)
              Text(context.tr.internetM),
            Text(context.tr.loadError),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onPressed, child: Text(context.tr.retry)),
          ],
        ),
      ),
    );
  }
}
