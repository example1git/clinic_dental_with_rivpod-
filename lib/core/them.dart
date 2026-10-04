import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  //************************************************************************************************************************ */
  // static final sharedPref = Get.find<SharedPrefService>();
  // static FlexScheme? get schema => Utils.flexschema.firstWhereOrNull(
  //   (element) => element.name == sharedPref.getTheme(),
  // );
  //************************************************************************************************************************ */

  static ThemeData light =
      FlexThemeData.light(
        useMaterial3: true,

        // Using FlexColorScheme built-in FlexScheme enum based colors
        // scheme: schema ?? FlexScheme.cyanM3,
        // Component theme configurations for light mode.
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          useM2StyleDividerInM3: true,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          alignedDropdown: true,
          navigationRailUseIndicator: true,
        ),
        // Direct ThemeData properties.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: whitecolor,
        ),
        // listTileTheme: ListTileThemeData(textColor: whitecolor),
      );
}
