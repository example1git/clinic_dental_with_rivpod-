import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/controllers/auth_dependcies.dart';

class Verify extends ConsumerStatefulWidget {
  const Verify({super.key});

  @override
  ConsumerState<Verify> createState() => _VerifyState();
}

class _VerifyState extends ConsumerState<Verify> {
  late final List<TextEditingController> controllers;

  late final List<FocusNode> focusNodes;

  String get code => controllers.map((e) => e.text).join();

  @override
  void initState() {
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    ref.read(authProvider.notifier).resendCode();
    super.initState();
  }

  @override
  void dispose() {
    disposeController();

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _buildCodeField(index, context),
                ),
              ),
            ),
            // Material(child: Pinput(length: 4, onCompleted: (value) {})),
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

  Widget _buildCodeField(int index, BuildContext context) {
    return SizedBox(
      width: 62,
      height: 62,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,

        style: context.bodyLarge?.copyWith(
          color: context.primarycolor,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: context.primaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.raduis),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.raduis),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.raduis),
            borderSide: BorderSide(
              color: context.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          onChanged(value, index, code, context);
        },
      ),
    );
  }

  void disposeController() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
  }

  void clearController() {
    for (var c in controllers) {
      c.clear();
    }
    for (var f in focusNodes) {
      f.unfocus();
    }
  }

  void onChanged(
    String value,
    int index,
    String code,
    BuildContext context,
  ) async {
    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    if (code.length == 4) {
      final codeSend = ref.read(codeSendProvider.notifier).state;
      if (codeSend != code) {
      clearController();
        ErrorHndel.handleError(ErrorType.code, context);
        return;
      }
      await ref.read(authProvider.notifier).signUp();
    }
  }
}
