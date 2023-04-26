import 'package:flutter/material.dart';
import 'package:qaza_tracker/src/features/common/presentation/dialogs/date_range.dart';
import 'package:qaza_tracker/src/features/login/presentation/pages/login_page.dart';
import 'package:qaza_tracker/src/features/main/presentation/pages/main_page.dart';

abstract class AppRoutes {

  static const main = '/main';
  static const login = '/login';
  static const dateRange = '/date_range';

  static final routes = <String, WidgetBuilder>{
    main: (context) => const MainPage(),
    login: (context) => const LoginPage(),
    dateRange: (context) => const CustomDateRange(),
  };

}
