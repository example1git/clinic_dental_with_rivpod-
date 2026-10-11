import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/provider/lang_provider.dart';
import 'package:mysen/core/provider/theme_provider.dart';
import 'package:mysen/core/them.dart';
import 'package:mysen/translate/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:mysen/core/approut.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSession();
    }
  }

  void _checkSession() {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ref.watch(themeProvider);

    final language = ref.watch(languageProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      builder: DevicePreview.appBuilder,

      title: 'Flutter Demo',

      locale: Locale(language),

      theme: AppTheme.light(scheme: scheme),

      darkTheme: AppTheme.dark(scheme: scheme),

      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
