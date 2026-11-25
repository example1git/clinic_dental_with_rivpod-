import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  final GlobalKey<FormState> sigUpKey = GlobalKey<FormState>();

  late TextEditingController phone;
  @override
  void initState() {
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  void signupFirst(BuildContext context, WidgetRef ref) {
    try {
      if (!sigUpKey.currentState!.validate()) {
        return;
      }
      ref.read(phoneProvider.notifier).state = phone.text;

      context.pushReplacement(AppRoutes.verfiy);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: context.primarycolor, leading: const Backed()),
      backgroundColor: context.primarycolor,
      body: Form(
        key: sigUpKey,
        child: Column(
          spacing: context.spacing,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(context.tr.signUp, style: context.bodyLarge)),
            FractionallySizedBox(
              widthFactor: .8,
              child: MytexFormFiled(
                filled: false,
                controller: phone,
                label: context.tr.phone,
                validate: Validate.phone,
                keyboardType: TextInputType.number,
                prefixText: '966+:',
              ),
            ),
            Consumer(
              builder: (context, ref, child) => FractionallySizedBox(
                widthFactor: .8,
                child: OutlinedButton(
                  onPressed: () {
                    signupFirst(context, ref);
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
    );
  }
}
