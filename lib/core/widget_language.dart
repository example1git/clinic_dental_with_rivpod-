import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/provider/lang_provider.dart';
import 'package:mysen/core/utiles.dart';

class WidgetLanguage extends StatelessWidget {
  const WidgetLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(context.tr.chooseLanguage, style: context.bodyMeduim),
        Consumer(
          builder: (context, ref, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: context.iconButtonStyle?.copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    context.primaryContainer,
                  ),
                ),
                onPressed: () {
                  ref.read(languageProvider.notifier).setLanguage('ar');
                  context.pop();
                },
                child: Text(context.tr.arabic),
              ),
              OutlinedButton(
                style: context.iconButtonStyle?.copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                    context.primaryContainer,
                  ),
                ),
                onPressed: () {
                  ref.read(languageProvider.notifier).setLanguage('en');
                  context.pop();
                },
                child: Text(context.tr.english),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
