import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/providers.dart';

import 'package:mysen/core/utiles.dart';

final themeProvider = NotifierProvider<ThemeNotifier, FlexScheme>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<FlexScheme> {
  @override
  FlexScheme build() {
    final savedTheme = ref.read(sharedPrefServiceProvider).getTheme();

    return _parseTheme(savedTheme);
  }

  Future<void> changeTheme(FlexScheme scheme) async {
    await ref.read(sharedPrefServiceProvider).setTheme(scheme.name);

    state = scheme;
  }

  Future<void> resetTheme() async {
    await ref.read(sharedPrefServiceProvider).removeTheme();

    state = FlexScheme.cyanM3;
  }

  FlexScheme _parseTheme(String? value) {
    if (value == null) {
      return FlexScheme.cyanM3;
    }

    return Utils.flexschema.firstWhere(
      (element) => element.name == value,
      orElse: () => FlexScheme.cyanM3,
    );
  }
}
