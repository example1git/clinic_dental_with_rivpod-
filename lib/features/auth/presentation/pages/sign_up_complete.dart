import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class SignUpComplete extends StatefulWidget {
  const SignUpComplete({super.key});

  @override
  State<SignUpComplete> createState() => _SignUpCompleteState();
}

class _SignUpCompleteState extends State<SignUpComplete> {
  final GlobalKey<FormState> sigUpCompleteKey = GlobalKey<FormState>();

  late final TextEditingController name;

  late final TextEditingController nickName;
  @override
  void initState() {
    name = TextEditingController();
    nickName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    nickName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primarycolor,
      body: SizedBox.expand(
        child: Form(
          key: sigUpCompleteKey,
          child: Column(
            spacing: context.spacing,

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.tr.addName, style: context.bodyLarge),

              FractionallySizedBox(
                widthFactor: .8,
                child: MytexFormFiled(
                  filled: false,
                  controller: name,
                  label: context.tr.name,
                  validate: Validate.name,
                ),
              ),
              FractionallySizedBox(
                widthFactor: .8,

                child: MytexFormFiled(
                  filled: false,
                  controller: nickName,
                  label: context.tr.nickName,
                  validate: Validate.nickName,
                ),
              ),

              Consumer(
                builder: (context, ref, child) => FractionallySizedBox(
                  widthFactor: .8,

                  child: OutlinedButton(
                    onPressed: () {
                      if (!sigUpCompleteKey.currentState!.validate()) {
                        return;
                      }
                      ref
                          .read(authProvider.notifier)
                          .signUpComplete(name.text, nickName.text);
                    },
                    style: context.iconButtonStyle?.copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                        context.primaryContainer,
                      ),
                    ),
                    child: Text(
                      context.tr.done,
                      style: context.bodyMeduim?.copyWith(
                        color: context.primarycolor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
