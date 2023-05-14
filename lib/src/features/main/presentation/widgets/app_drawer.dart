import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/config/themes/app_icons.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/app/presentation/blocs/app_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _languageCode = uz;
  String themMode = LocalStorage.themeMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(context),
          ListTile(
            title: DropdownButton(
              value: context.locale.languageCode,
              items: itemsLanguage,
              underline: const SizedBox(),
              onChanged: (value) {
                if (value != _languageCode) {
                  context.setLocale(Locale(value ?? _languageCode));
                  setState(() {
                    _languageCode = value ?? en;
                  });
                  LocalStorage.setLocale(_languageCode);
                }
              },
            ),
          ),
          ListTile(
            title: DropdownButton(
              value: themMode,
              items: itemsThemeMode,
              underline: const SizedBox(),
              onChanged: (value) {
                if (value != themMode) {
                  context
                      .read<AppBloc>()
                      .add(ChangeThemeModeEvent(value ?? light));
                  LocalStorage.setThemeMode(value ?? light);
                  setState(() {
                    themMode = value ?? light;
                  });
                }
              },
            ),
          ),
          ListTile(
            title: OutlinedButton(
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false);
                await FirebaseAuth.instance.signOut();
                GoogleSignIn().signOut();
                await LocalStorage.clearProfile();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(32),
                side: const BorderSide(color: Colors.red),
              ),
              child: Text(
                LocaleKeys.exit.tr(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) => Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor
                  ?.withOpacity(0.5),
              foregroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor
                  ?.withOpacity(0.5),
              backgroundImage: NetworkImage(LocalStorage.image),
            ),
            kHeight8,
            Text(
              LocalStorage.email.isEmpty ? 'Not signed' : LocalStorage.email,
              style: const TextStyle(color: Colors.white),
            ),
            kHeight8,
          ],
        ),
      );

  List<DropdownMenuItem<String>> itemsLanguage = [
    DropdownMenuItem(
      value: en,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.en),
          kWidth8,
          const Text('English'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: uz,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.uz),
          kWidth8,
          const Text("O'zbek"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: ru,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.ru),
          kWidth8,
          const Text('Русский'),
        ],
      ),
    ),
  ];

  List<DropdownMenuItem<String>> itemsThemeMode = [
    const DropdownMenuItem(
      value: light,
      child: Row(
        children: [
          Icon(Icons.light_mode_outlined),
          kWidth8,
          Text('Light'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: dark,
      child: Row(
        children: [
          Icon(Icons.dark_mode),
          kWidth8,
          Text("Dark"),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: system,
      child: Row(
        children: [
          Icon(Icons.dark_mode_outlined),
          kWidth8,
          Text('System'),
        ],
      ),
    ),
  ];
}
