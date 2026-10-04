import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/localnotfication.dart';
import 'package:mysen/my_app.dart';

// import 'package:mysen/features/shared/screen/my_app.dart' show MyApp;
// import 'package:mysen/features/shared/services/sharedprefrenceservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseInfo().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Get.putAsync<SharedPrefService>(
  //   () async => await SharedPrefService().init(),
  // );
  await LocalNotificationService().init();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}
