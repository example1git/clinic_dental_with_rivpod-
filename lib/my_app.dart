import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysen/core/approut.dart';
import 'package:mysen/core/them.dart';
import 'package:mysen/core/lang.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final client = Supabase.instance.client;
      final session = client.auth.currentSession;

      if (session == null) {
        // print("⚠️ No active session when app resumed");
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final sharedPref = Get.find<SharedPrefService>();

    return GetMaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      // locale: Locale(sharedPref.getLang() ?? 'ar'),
      title: 'Flutter Demo',
      translations: Lang(),
      theme: AppTheme.light,
      initialRoute: Approut.startscreen,
      // getPages: Approut.getpages,
    );
  }
}
