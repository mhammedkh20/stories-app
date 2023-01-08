import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_app/core/storage/pref/pref_keys.dart';

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();

  late SharedPreferences _preferences;

  SharedPrefController._internal();

  factory SharedPrefController() => _instance;

  Future<SharedPreferences> initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  SharedPreferences get prefManager => _preferences;

  Future<bool> setListUserBan(String value) async =>
      await _preferences.setString(PrefKeys.LIST_BAN, value);

  String? get getListUserBan =>
      _preferences.getString(PrefKeys.LIST_BAN) ?? null;

  Future<bool> setRunApp(String value) async =>
      await _preferences.setString(PrefKeys.RUN_APP, value);

  String? get getRunApp => _preferences.getString(PrefKeys.RUN_APP) ?? null;
}
