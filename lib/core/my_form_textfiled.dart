import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

enum Validate { name, nickName, phone, equalization, location, price, none }

// ignore: must_be_immutable
class MytexFormFiled extends StatelessWidget {
  String? validatorName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field is empty";
    }

    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.length != 3) {
      return "faild names";
    }

    if (parts.any((part) => part.length < 3)) {
      return "faild names";
    }

    return null;
  }

  String? validatorNickName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field is empty";
    }

    final parts = value.trim().split(RegExp(r'\s+'));

    if (parts.any((part) => part.length == 1) || parts.length > 2) {
      return "faild Nickames";
    }

    return null;
  }

  String? validatorPhone(String? p0) {
    if (p0 == null || p0.isEmpty) {
      return "Field is empty";
    }
    if (!(p0.length == 10)) {
      return "number is not valid";
    }
    if (!(p0.startsWith("05") || p0.startsWith("5"))) {
      return "number is not valid";
    }
    return null;
  }

  String? validatorPrice(String? p0) {
    if (p0 == null || p0.isEmpty) {
      return "Field is empty";
    }

    return null;
  }

  String? validatorLocation(String? p0) {
    if (p0 == null || p0.isEmpty) {
      return "Field is empty";
    }

    return null;
  }

  String? validateNone(String? p0) {
    return null;
  }

  String? validatorequalization(String? p0) {
    if (p0 == null || p0.isEmpty) {
      return 'Field is empty';
    }

    return null;
  }

  MytexFormFiled({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.onChanged,
    this.filled,
    this.style,
    this.labelStyle,
    this.fillColor,
    required this.validate,
    this.prefixText,
    this.prefix,
    this.isobscureText = false,
    this.autovalidateMode,
    this.maxLength,
  });

  final void Function(String)? onChanged;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String label;
  final String? prefixText;
  final int? maxLength;

  final TextInputType? keyboardType;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final Widget? prefix;
  bool isobscureText;

  final Validate validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,

      style: style ?? context.bodyMeduim,
      inputFormatters: switch (validate) {
        Validate.name => [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF\s]')),
        ],
        Validate.nickName => [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF\s]')),
        ],
        Validate.phone => [FilteringTextInputFormatter.digitsOnly],
        Validate.equalization => [],
        Validate.location => [],

        Validate.none => [],
        Validate.price => [FilteringTextInputFormatter.digitsOnly],
      },

      validator: switch (validate) {
        Validate.phone => validatorPhone,
        Validate.name => validatorName,
        Validate.nickName => validatorNickName,
        Validate.equalization => validatorequalization,
        Validate.price => validatorPrice,
        Validate.location => validatorLocation,

        Validate.none => validateNone,
      },

      cursorColor: whitecolor,
      maxLength: maxLength,

      decoration: InputDecoration(
        counterText: '',
        errorStyle: context.bodyMeduim?.copyWith(
          color: context.colorScheme.error,
        ),
        suffix: prefix,
        prefixText: prefixText,
        prefixStyle: context.bodyMeduim?.copyWith(
          color: context.primaryContainer,
        ),
        contentPadding: EdgeInsets.all(
          MediaQuery.of(context).size.shortestSide * .03,
        ),
        floatingLabelStyle:
            labelStyle ??
            context.titleLable?.copyWith(color: context.primaryContainer),
        labelStyle: labelStyle ?? context.titleLable,
        filled: filled,
        labelText: label,
        fillColor: fillColor,

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.raduis),
          borderSide: BorderSide(
            color: context.colorScheme.error,
            width: MediaQuery.of(context).size.shortestSide * .003,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.raduis),
          borderSide: BorderSide(
            color: context.primaryContainer,
            width: MediaQuery.of(context).size.shortestSide * .003,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.raduis),
          borderSide: BorderSide(
            color: whitecolor,
            width: MediaQuery.of(context).size.shortestSide * .003,
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.raduis),
          borderSide: BorderSide(
            color: whitecolor,
            width: MediaQuery.of(context).size.shortestSide * .003,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.raduis),
          borderSide: BorderSide(
            color: whitecolor,
            width: MediaQuery.of(context).size.shortestSide * .0025,
          ),
        ),
      ),
      obscureText: isobscureText,
    );
  }
}
