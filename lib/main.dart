import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qaza_tracker/generated/codegen_loader.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/get_it/service_locator.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/app/presentation/pages/qaza_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qaza_tracker/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.getInstance();
  await setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(en),
        Locale(uz),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale(LocalStorage.getLocale),
      startLocale: Locale(LocalStorage.getLocale),
      assetLoader: const CodegenLoader(),
      child: const QazaApp(),
    ),
  );
}
