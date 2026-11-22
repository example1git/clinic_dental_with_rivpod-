import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';
import 'package:pinput/pinput.dart';

class Verify extends ConsumerStatefulWidget {
  const Verify({super.key});

  @override
  ConsumerState<Verify> createState() => _VerifyState();
}

class _VerifyState extends ConsumerState<Verify> {
  @override
  void initState() {
    ref.read(authProvider.notifier).resendCode();
    super.initState();
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
      body: SafeArea(
        child: Column(
          spacing: context.spacing,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Stack(
              children: [
                Center(
                  child: Text(context.tr.verify, style: context.bodyLarge),
                ),

                if (ref.watch(isBackProvider.notifier).state)
                  Consumer(
                    builder: (context, ref, child) => Align(
                      alignment: Alignment.topLeft,
                      child: ref.watch(isBackProvider.notifier).state
                          ? IconButton(
                              style: context.iconButtonStyle,
                              onPressed: () {
                                context.go(AppRoutes.sigin);
                              },
                              icon: const Icon(Icons.arrow_back),
                            )
                          : null,
                    ),
                  ),
              ],
            ),

            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 4,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                defaultPinTheme: PinTheme(
                  width: 62,
                  height: 62,
                  textStyle: context.bodyLarge?.copyWith(
                    color: context.primarycolor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: context.primaryContainer,
                    borderRadius: BorderRadius.circular(context.raduis),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 62,
                  height: 62,
                  textStyle: context.bodyLarge?.copyWith(
                    color: context.primarycolor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: context.primaryContainer,
                    borderRadius: BorderRadius.circular(context.raduis),
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onCompleted: (value) async {
                  final codeSend = ref.read(codeSendProvider.notifier).state;

                  if (codeSend != value) {
                    ErrorHndel.handleError(ErrorType.code, context);
                    return;
                  }

                  await ref.read(authProvider.notifier).signUp();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.tr.messageResend, style: context.bodyLarge),
                TextButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).resendCode();
                  },
                  child: Text(
                    context.tr.resend,
                    style: context.bodyMeduim?.copyWith(
                      color: context.primaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
