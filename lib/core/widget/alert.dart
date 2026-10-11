import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/utiles.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.confirme,
    required this.title,
    required this.isLoading,
  });

  final String title;
  final void Function() confirme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(color: context.primaryContainer),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Text(title, style: context.bodyMeduim),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: context.padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Expanded(flex: 1, child: SizedBox.shrink()),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  context.tr.cancel,
                                  style: context.bodyMeduim?.copyWith(
                                    color: context.primaryContainer,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: confirme,
                                child: Text(
                                  context.tr.ok,
                                  style: context.bodyMeduim?.copyWith(
                                    color: context.primaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
