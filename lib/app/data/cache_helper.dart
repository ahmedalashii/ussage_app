import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussage_app/app/data/models/user.dart';

class CacheController {
  CacheController._() {
    initSharedPreferences();
  }

  static final CacheController _instance = CacheController._();

  static CacheController get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future setCookie(String token) async {
    await _sharedPreferences.setString('cookie', token);
  }

  String getCookie() {
    return _sharedPreferences.getString('cookie') ?? '';
  }

  Future setDeviceId(String deviceId) async {
    await _sharedPreferences.setString('deviceId', deviceId);
  }

  String getDeviceId() {
    return _sharedPreferences.getString('deviceId') ?? '';
  }

  Future setUserId(String id) async {
    await _sharedPreferences.setString('userId', id);
  }

  Future cacheLoggedInUser(Map<String, dynamic> loggedInUser) async {
    await _sharedPreferences.setString(
        "loggedInUser", jsonEncode(loggedInUser));
  }

  User? getCachedLoggedInUser() {
    if (_sharedPreferences.getString("loggedInUser") != null) {
      return User.fromJSON(
          json.decode(_sharedPreferences.getString("loggedInUser")!)
              as Map<String, dynamic>);
    }
    return null;
  }

  Future removeCachedLoggedInUser() async {
    await _sharedPreferences.remove("loggedInUser");
  }

  String getUserId() {
    return _sharedPreferences.getString('userId') ?? "";
  }

  Future setLangCode(String langCode) async {
    await _sharedPreferences.setString('langCode', langCode);
  }

  String getLangCode() {
    return _sharedPreferences.getString('langCode') ?? 'en';
  }

  Future setUserDisplayName(String userDisplayName) async {
    await _sharedPreferences.setString('userDisplayName', userDisplayName);
  }

  String getuserDisplayName() {
    return _sharedPreferences.getString('userDisplayName') ?? '';
  }

  Future setUserEmail(String email) async {
    await _sharedPreferences.setString('email', email);
  }

  Future setUserName(String name) async {
    await _sharedPreferences.setString('name', name);
  }

  String getUserName() {
    return _sharedPreferences.getString('name') ?? '';
  }

  String getUserEmail() {
    return _sharedPreferences.getString('email') ?? '';
  }

  Future setAvatarLink(String avatar) async {
    await _sharedPreferences.setString('avatar', avatar);
  }

  String getAvatarLink() {
    return _sharedPreferences.getString('avatar') ??
        "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg";
  }

  Future setAuthed(bool authed) async {
    await _sharedPreferences.setBool('authed', authed);
  }

  bool authenticated() {
    return _sharedPreferences.getBool('authed') ?? false;
  }

  Future setDarkMode(bool isDark) async {
    await _sharedPreferences.setBool('isDark', isDark);
  }

  bool isDarkMode() {
    return _sharedPreferences.getBool('isDark') ?? false;
  }
}
