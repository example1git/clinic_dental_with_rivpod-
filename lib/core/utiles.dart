import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/translate/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

enum Gender { male, female }

enum Role { user, doctor }

enum StateRequest { completed, reject, waiting, accepted, none }

class Utils {
  static void showSnackBar({
    required BuildContext context,
    Duration duration = const Duration(seconds: 5),
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final size = MediaQuery.sizeOf(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: context.primaryContainer,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: blackcolor.withAlpha(20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: whitecolor.withAlpha(10)),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: size.width > 600
              ? size.shortestSide * .04
              : size.shortestSide * .015,
          vertical: size.shortestSide * .015,
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: size.shortestSide * .015,
          ),
          child: Text(
            textAlign: TextAlign.justify,
            maxLines: 2,

            message,
            style: context.bodyMeduim,
          ),
        ),
      ),
    );
  }

  static void showMyDialog({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    ShapeBorder? shape,
    Color? color,
    Color? colorDialog,
    double sigmaX = 10,
    double sigmaY = 10,
    double? widthFactor,
    double? heightFactor,
    bool dismissible = false,
  }) async {
    await showDialog(
      barrierColor: color ?? blackcolor.withAlpha(150),
      barrierDismissible: dismissible,
      context: context,
      builder: (_) => SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),

          child: Dialog(
            shape: shape,
            insetPadding: padding ?? const EdgeInsets.all(10),
            backgroundColor: colorDialog ?? whitecolor.withAlpha(0),
            child: FractionallySizedBox(
              widthFactor: widthFactor ?? 1,
              heightFactor: heightFactor ?? 1,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  static RealtimeChannel setupRealtimeChannel({
    required String tableName,
    void Function(PostgresChangePayload payload)? onInsert,
    void Function(PostgresChangePayload payload)? onUpdate,
    void Function(PostgresChangePayload payload)? onDelete,
  }) {
    final channel = Supabase.instance.client.channel('public:$tableName');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: tableName,
      callback: (payload) {
        if (onInsert != null) onInsert(payload);
      },
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: tableName,
      callback: (payload) {
        if (onUpdate != null) onUpdate(payload);
      },
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.delete,
      schema: 'public',
      table: tableName,
      callback: (payload) {
        if (onDelete != null) onDelete(payload);
      },
    );

    channel.subscribe();

    return channel;
  }

  static List<FlexScheme> flexschema = [
    FlexScheme.deepBlue,
    FlexScheme.barossa,
    FlexScheme.money,
    FlexScheme.bigStone,
    FlexScheme.tealM3,
    FlexScheme.cyanM3,
  ];

  static List<Map> listTheme = [
    {
      'name': MyFlexTheme.deepBlue.name,
      'primary': const Color(0xFF223A5E),
      'primaryContainer': const Color(0xFF97BAEA),
    },
    {
      'name': MyFlexTheme.barossa.name,
      'primary': const Color(0xFF4E0029),
      'primaryContainer': const Color(0xFFBDA5B1),
    },
    {
      'name': MyFlexTheme.money.name,
      'primary': const Color(0xFF264E36),
      'primaryContainer': const Color(0xFF94BDA5),
    },
    {
      'name': MyFlexTheme.bigStone.name,
      'primary': const Color(0xFF1A2C42),
      'primaryContainer': const Color(0xFFB1C0DD),
    },
    {
      'name': MyFlexTheme.tealM3.name,
      'primary': const Color(0xFF006A60),
      'primaryContainer': const Color(0xFFBBEDE6),
    },
    {
      'name': MyFlexTheme.cyanM3.name,
      'primary': const Color(0xFF006876),
      'primaryContainer': const Color(0xFFA1EFFF),
    },
  ];
}

enum MyFlexTheme { deepBlue, barossa, money, bigStone, tealM3, cyanM3 }

extension MyTheme on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get primarycolor => Theme.of(this).primaryColor;
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;
  TextStyle? get bodyLarge => TextStyle(
    color: whitecolor,
    fontSize: MediaQuery.of(this).size.shortestSide * .043,
  );
  TextStyle? get bodyMeduim => TextStyle(
    color: whitecolor,
    fontSize: MediaQuery.of(this).size.shortestSide * .035,
  );
  // TextStyle? get bodySmall => TextStyle(
  //   color: primarycolor,
  //   fontSize: MediaQuery.of(this).size.shortestSide * .035,
  // );
  TextStyle? get bodySmallNotfication => TextStyle(
    color: primarycolor,
    fontSize: MediaQuery.of(this).size.shortestSide * .035,
  );
  TextStyle? get titleLarge => TextStyle(
    color: primaryContainer,
    fontSize: MediaQuery.of(this).size.shortestSide * .06,
  );
  TextStyle? get titleLable => TextStyle(
    color: whitecolor,
    fontSize: MediaQuery.of(this).size.width > 600
        ? MediaQuery.of(this).size.shortestSide * .03
        : MediaQuery.of(this).size.shortestSide * .035,
  );
  TextStyle? get number => TextStyle(
    color: whitecolor,
    fontSize: MediaQuery.of(this).size.shortestSide * .04,
  );
  TextStyle? get textAppointment => TextStyle(
    color: primaryContainer,
    fontSize: MediaQuery.of(this).size.shortestSide * .035,
  );
  TextStyle? get mysen => TextStyle(
    letterSpacing: 2,
    color: primaryContainer,
    fontSize: MediaQuery.of(this).size.shortestSide * .08,
  );
  ButtonStyle? get iconButtonStyle =>
      Theme.of(this).iconButtonTheme.style!.copyWith(
        iconColor: WidgetStatePropertyAll(primaryContainer),
        iconSize: WidgetStatePropertyAll(
          MediaQuery.of(this).size.shortestSide * .06,
        ),
      );
  ButtonStyle? get outlinedButtonStyle =>
      Theme.of(this).outlinedButtonTheme.style!.copyWith(
        overlayColor: WidgetStatePropertyAll(
          Theme.of(this).colorScheme.primaryContainer,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: Theme.of(this).colorScheme.primaryContainer,
            width: MediaQuery.of(this).size.shortestSide * .003,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(
              MediaQuery.of(this).size.shortestSide * .02,
            ),
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(
            MediaQuery.of(this).size.width / 2,
            MediaQuery.of(this).size.shortestSide * .1,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(whitecolor),
      );
  double get iconSize => MediaQuery.of(this).size.shortestSide * .05;
  Size get mediaSize => MediaQuery.of(this).size;
  double get raduis => MediaQuery.of(this).size.shortestSide * .02;
  double get margin => MediaQuery.of(this).size.shortestSide * .02;
  double get padding => MediaQuery.of(this).size.shortestSide * .02;
  double get spacing => MediaQuery.of(this).size.shortestSide * .08;
}

extension Loading on Widget {
  Widget loading(bool isloading, Color color) {
    return isloading
        ? Center(child: CircularProgressIndicator(color: color))
        : this;
  }
}

extension AppLocalizationTr on BuildContext {
  AppLocalizations get tr {
    return AppLocalizations.of(this)!;
  }
}
//        connectvity

class InternetService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  InternetService() {
    // استمع لتغيرات الشبكة
    _connectivity.onConnectivityChanged.listen((event) async {
      final hasInternet = await _checkInternet();
      if (!_controller.isClosed) {
        _controller.add(hasInternet);
      }
    });

    // تحقق أول مرة عند التشغيل
    _initCheck();
  }

  Future<void> _initCheck() async {
    final hasInternet = await _checkInternet();
    if (!_controller.isClosed) {
      _controller.add(hasInternet);
    }
  }

  /// Stream لمراقبة الاتصال
  Stream<bool> get onStatusChange => _controller.stream;

  /// تحقق فوري (مرة واحدة)
  Future<bool> checkNow() async => await _checkInternet();

  /// التحقق من وجود إنترنت فعلي
  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 2));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }

  void dispose() {
    _controller.close();
  }
}
