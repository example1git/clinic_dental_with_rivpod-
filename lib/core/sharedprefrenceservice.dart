import 'package:get/get.dart';
import 'package:mysen/core/utiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {
  late SharedPreferences _theme;
  late SharedPreferences _rolel;
  late SharedPreferences _language;

  /// init service
  Future<SharedPrefService> init() async {
    _theme = await SharedPreferences.getInstance();
    _rolel = await SharedPreferences.getInstance();
    _language = await SharedPreferences.getInstance();

    return this;
  }

  /// set theme
  Future<void> setTheme(String flexScheme) async {
    await _theme.setString('theme', flexScheme);
  }

  /// get theme
  String? getTheme() {
    return _theme.getString('theme');
  }

  /// remove theme
  Future<void> removeTheme() async {
    await _theme.clear();
  }

  /// set role

  Future<void> setRole(Role role) async {
    await _rolel.setString('role', role.name);
  }

  /// get role
  String? getRole() {
    return _rolel.getString('role');
  }

  /// remove role
  Future<void> removeRole() async {
    await _rolel.clear();
  }

  /// set language
  Future<void> setLang(String lang) async {
    await _language.setString('lang', lang);
  }

  /// get language
  String? getLang() {
    return _language.getString('lang');
  }

  /// remove language
  Future<void> removeLang() async {
    await _language.clear();
  }
}
