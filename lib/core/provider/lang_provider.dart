import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/providers.dart';

final languageProvider = NotifierProvider<LanguageNotifier, String>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<String> {
  @override
  String build() {
    final savedLanguage = ref.read(sharedPrefServiceProvider).getLang();

    return savedLanguage ?? 'ar';
  }

  Future<void> setLanguage(String language) async {
    await ref.read(sharedPrefServiceProvider).setLang(language);

    state = language;
  }

  Future<void> resetLanguage() async {
    await ref.read(sharedPrefServiceProvider).removeLang();

    state = 'ar';
  }
}
