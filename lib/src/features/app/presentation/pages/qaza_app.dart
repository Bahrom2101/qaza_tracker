import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';

class QazaApp extends StatefulWidget {
  const QazaApp({Key? key}) : super(key: key);

  @override
  State<QazaApp> createState() => _QazaAppState();
}

class _QazaAppState extends State<QazaApp> {
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticated = LocalStorage.signed;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: MaterialApp(
        navigatorKey: AppConsts.navigatorKey,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: appName,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        initialRoute: !_authenticated ? AppRoutes.login : AppRoutes.main,
        routes: AppRoutes.routes,
      ),
    );
  }
}
