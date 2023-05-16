import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'Email';
  static const _islogin = 'login';
  static const _keyType = 'type';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveUser(String name) async {
    await _preferences!.setString(_keyUsername, name);
    await _preferences!.setBool(_islogin, true);
  }

  static Future saveType(String type) async {
    await _preferences!.setString(_keyType, type);
    await _preferences!.setBool(_islogin, true);
  }

  static Future logout() async {
    await _preferences!.setString(_keyUsername, '');
    await _preferences!.setBool(_islogin, false);
    _preferences!.remove(_keyUsername);
    _preferences!.remove(_keyType);
  }

  static String? getUsername() {
    if (_preferences == null) {
      init();
    }
    return _preferences!.getString(_keyUsername);
  }

  static String? getType() {
    if (_preferences == null) {
      init();
    }
    return _preferences!.getString(_keyType);
  }

  static bool? getlogindata() {
    if (_preferences == null) {
      init();
    }
    return _preferences!.getBool(_islogin);
  }
}
