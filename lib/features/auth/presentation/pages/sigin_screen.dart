import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget_language.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class SiginScreen extends ConsumerStatefulWidget {
  const SiginScreen({super.key});

  @override
  ConsumerState<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends ConsumerState<SiginScreen> {
  final GlobalKey<FormState> siginKey = GlobalKey<FormState>();

  late TextEditingController phone;
  @override
  void initState() {
    super.initState();
    ref.invalidate(authProvider);
    phone = TextEditingController();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        loading: () => Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
        error: (error, stackTrace) {
          if (error is InternetFailure) {
            ErrorHndel.handleError(ErrorType.internet, context);
            return;
          }
          if (error is RequetsTimeFailure) {
            ErrorHndel.handleError(ErrorType.timeout, context);
            return;
          }

          ErrorHndel.handleError(ErrorType.error, context);
        },
      );
    });
    return Scaffold(
      backgroundColor: context.primarycolor,
      body: Form(
        key: siginKey,
        child: SafeArea(
          minimum: EdgeInsets.all(context.padding),
          child: Column(
            spacing: context.spacing,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Consumer(
                  builder: (context, ref, child) => IconButton(
                    style: context.iconButtonStyle,
                    onPressed: () {
                      Utils.showMyDialog(
                        widthFactor: .8,
                        heightFactor: .3,
                        dismissible: true,
                        colorDialog: context.primarycolor,
                        context: context,
                        child: WidgetLanguage(),
                      );
                    },
                    icon: const Icon(Icons.language),
                  ),
                ),
              ),
              const Spacer(),
              Center(child: Text(context.tr.signIn, style: context.bodyLarge)),

              FractionallySizedBox(
                widthFactor: .8,
                child: MytexFormFiled(
                  filled: false,
                  controller: phone,
                  label: context.tr.phone,
                  prefixText: '966+:',
                  validate: Validate.phone,
                  keyboardType: TextInputType.number,
                ),
              ),

              FractionallySizedBox(
                widthFactor: .8,
                child:
                    OutlinedButton(
                      onPressed: () async {
                        if (!siginKey.currentState!.validate()) {
                          return;
                        }
                        await ref
                            .read(authProvider.notifier)
                            .signIn(phone.text);
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
                    ).loading(
                      ref.watch(authProvider).isLoading,
                      context.primaryContainer,
                    ),
              ),

              FractionallySizedBox(
                widthFactor: .8,
                child: OutlinedButton(
                  onPressed: () {
                    context.push(AppRoutes.sigup);
                    // context.push(AppRoutes.verfiy);
                  },
                  style: context.iconButtonStyle?.copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      context.primaryContainer,
                    ),
                  ),
                  child: Text(
                    context.tr.signUp,
                    style: context.bodyMeduim?.copyWith(
                      color: context.primarycolor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
