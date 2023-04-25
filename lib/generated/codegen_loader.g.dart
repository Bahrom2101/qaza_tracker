// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "sign_in_google": "Войти через Google",
  "continue_without_sign_in": "Продолжить без входа",
  "error_occurred": "Возникла ошибка",
  "fajr": "Фаджр",
  "zuhr": "Зухр",
  "asr": "Аср",
  "maghrib": "Магриб",
  "isha": "Иша",
  "witr": "Витр",
  "add_period": "Каза намазы в этот период будет добавлен",
  "exit": "Выход"
};
static const Map<String,dynamic> en = {
  "sign_in_google": "Sign in with Google",
  "continue_without_sign_in": "Continue without sign in",
  "error_occurred": "Error occurred",
  "fajr": "Fajr",
  "zuhr": "Zuhr",
  "asr": "Asr",
  "maghrib": "Maghrib",
  "isha": "Isha",
  "witr": "Witr",
  "add_period": "Qadaas in this period, will be added",
  "exit": "Exit"
};
static const Map<String,dynamic> uz = {
  "sign_in_google": "Google orqali kirish",
  "continue_without_sign_in": "Ro'yxatdan o'tmasdan kirish",
  "error_occurred": "Xatolik sodir bo'ldi",
  "fajr": "Bomdod",
  "zuhr": "Peshin",
  "asr": "Asr",
  "maghrib": "Shom",
  "isha": "Xufton",
  "witr": "Vitr",
  "add_period": "Shu oraliqdagi qazolar qo'shiladi",
  "exit": "Chiqish"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en, "uz": uz};
}
