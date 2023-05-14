import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/config/themes/app_theme.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/app/presentation/blocs/app_bloc.dart';

class QazaApp extends StatefulWidget {
  const QazaApp({Key? key}) : super(key: key);

  @override
  State<QazaApp> createState() => _QazaAppState();
}

class _QazaAppState extends State<QazaApp> {
  bool _authenticated = false;
  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppBloc(LocalStorage.themeMode);
    _authenticated = LocalStorage.signed;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return KeyboardDismisser(
            gestures: const [GestureType.onTap],
            child: AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness: LocalStorage.themeMode == dark
                    ? Brightness.light
                    : Brightness.dark,
                systemNavigationBarColor: LocalStorage.themeMode == dark
                    ? Colors.black
                    : Colors.white,
                systemNavigationBarIconBrightness:
                    LocalStorage.themeMode == dark
                        ? Brightness.light
                        : Brightness.dark,
              ),
              child: MaterialApp(
                navigatorKey: AppConsts.navigatorKey,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: state.themeMode == dark
                    ? ThemeMode.dark
                    : state.themeMode == light
                        ? ThemeMode.light
                        : ThemeMode.system,
                debugShowCheckedModeBanner: false,
                title: appName,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                initialRoute:
                    !_authenticated ? AppRoutes.login : AppRoutes.main,
                routes: AppRoutes.routes,
              ),
            ),
          );
        },
      ),
    );
  }
}
