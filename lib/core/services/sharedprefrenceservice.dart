import 'package:mysen/core/utiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPrefService(this._prefs);

  final SharedPreferences _prefs;

  static const String _themeKey = 'theme';
  static const String _roleKey = 'role';
  static const String _languageKey = 'lang';

  // -------------------------
  // Theme
  // -------------------------

  Future<bool> setTheme(String flexScheme) {
    return _prefs.setString(_themeKey, flexScheme);
  }

  String? getTheme() {
    return _prefs.getString(_themeKey);
  }

  Future<bool> removeTheme() {
    return _prefs.remove(_themeKey);
  }

  // -------------------------
  // Role
  // -------------------------

  Future<bool> setRole(Role role) {
    return _prefs.setString(_roleKey, role.name);
  }

  String? getRole() {
    return _prefs.getString(_roleKey);
  }

  Future<bool> removeRole() {
    return _prefs.remove(_roleKey);
  }

  // -------------------------
  // Language
  // -------------------------

  Future<bool> setLang(String lang) {
    return _prefs.setString(_languageKey, lang);
  }

  String? getLang() {
    return _prefs.getString(_languageKey);
  }

  Future<bool> removeLang() {
    return _prefs.remove(_languageKey);
  }
}
