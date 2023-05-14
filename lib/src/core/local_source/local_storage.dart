import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/storage_keys.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _localStorage;

  static Future<LocalStorage> getInstance() async {
    if (_instance == null) {
      final secureStorage = LocalStorage();
      await secureStorage._init();
      _instance = secureStorage;
    }
    return _instance!;
  }

  Future _init() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  static Future<void> setLocale(String value) async {
    await _localStorage?.setString(StorageKeys.locale, value);
  }

  static Future<void> setSigned(bool value) async {
    await _localStorage?.setBool(StorageKeys.signed, value);
  }

  static Future<void> setEmail(String value) async {
    await _localStorage?.setString(StorageKeys.email, value);
  }

  static Future<void> setFajr(int value) async {
    await _localStorage?.setInt(StorageKeys.fajr, value);
  }

  static Future<void> setZuhr(int value) async {
    await _localStorage?.setInt(StorageKeys.zuhr, value);
  }

  static Future<void> setAsr(int value) async {
    await _localStorage?.setInt(StorageKeys.asr, value);
  }

  static Future<void> setMaghrib(int value) async {
    await _localStorage?.setInt(StorageKeys.maghrib, value);
  }

  static Future<void> setIsha(int value) async {
    await _localStorage?.setInt(StorageKeys.isha, value);
  }

  static Future<void> setWitr(int value) async {
    await _localStorage?.setInt(StorageKeys.witr, value);
  }

  static Future<void> setThemeMode(String value) async {
    await _localStorage?.setString(StorageKeys.themeMode, value);
  }

  static Future<void> setImage(String value) async {
    await _localStorage?.setString(StorageKeys.image, value);
  }

  static Future<void> setUser(UserModel user) async {
    await _localStorage?.setString(StorageKeys.email, user.email);
    await _localStorage?.setInt(StorageKeys.fajr, user.fajr);
    await _localStorage?.setInt(StorageKeys.zuhr, user.zuhr);
    await _localStorage?.setInt(StorageKeys.asr, user.asr);
    await _localStorage?.setInt(StorageKeys.maghrib, user.maghrib);
    await _localStorage?.setInt(StorageKeys.isha, user.isha);
    await _localStorage?.setInt(StorageKeys.witr, user.witr);
  }

  static String get locale =>
      _localStorage?.getString(StorageKeys.locale) ?? en;

  static bool get signed => _localStorage?.getBool(StorageKeys.signed) ?? false;

  static String get email => _localStorage?.getString(StorageKeys.email) ?? '';

  static int get fajr => _localStorage?.getInt(StorageKeys.fajr) ?? 0;

  static int get zuhr => _localStorage?.getInt(StorageKeys.zuhr) ?? 0;

  static int get asr => _localStorage?.getInt(StorageKeys.asr) ?? 0;

  static int get maghrib => _localStorage?.getInt(StorageKeys.maghrib) ?? 0;

  static int get isha => _localStorage?.getInt(StorageKeys.isha) ?? 0;

  static int get witr => _localStorage?.getInt(StorageKeys.witr) ?? 0;

  static String get themeMode =>
      _localStorage?.getString(StorageKeys.themeMode) ?? system;

  static String get image => _localStorage?.getString(StorageKeys.image) ?? '';

  static UserModel get user => UserModel(
        email: email,
        fajr: fajr,
        zuhr: zuhr,
        asr: asr,
        maghrib: maghrib,
        isha: isha,
        witr: witr,
      );

  static Future<void> clearProfile() async {
    await setUser(const UserModel());
    await setImage('');
    await setSigned(false);
  }
}
