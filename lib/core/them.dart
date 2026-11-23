import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mysen/core/constant.dart';

abstract final class AppTheme {
  static ThemeData light({FlexScheme scheme = FlexScheme.cyanM3}) {
    return FlexThemeData.light(
      useMaterial3: true,

      scheme: scheme,

      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),

      visualDensity: FlexColorScheme.comfortablePlatformDensity,

      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    ).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: whitecolor,
      ),
    );
  }

  static ThemeData dark({FlexScheme scheme = FlexScheme.cyanM3}) {
    return FlexThemeData.dark(
      useMaterial3: true,

      scheme: scheme,

      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),

      visualDensity: FlexColorScheme.comfortablePlatformDensity,

      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    ).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: whitecolor,
      ),
    );
  }
}
