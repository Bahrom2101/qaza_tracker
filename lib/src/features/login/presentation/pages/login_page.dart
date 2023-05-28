import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/config/themes/app_icons.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/login/presentation/blocs/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _languageCode = uz;
  late LoginBloc bloc;

  List<DropdownMenuItem<String>> items = [
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

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();
    _languageCode = 'en';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.statusLogin.isSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.main,
              (route) => false,
            );
          }
          if (state.statusLogin.isFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48),
                        child: DropdownButton(
                          value: _languageCode,
                          items: items,
                          elevation: 4,
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
                      ElevatedButton(
                        onPressed: () async {
                          bloc.add(const GoogleSignInEvent());
                        },
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.google,
                              width: 24,
                              height: 24,
                            ),
                            kWidth16,
                            Text(
                              LocaleKeys.sign_in_google.tr(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      if (Platform.isIOS) ...[
                        kHeight8,
                        ElevatedButton(
                          onPressed: () async {
                            bloc.add(const AppleSignInEvent());
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.apple),
                              kWidth16,
                              Text(
                                LocaleKeys.sign_in_apple.tr(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                      kHeight8,
                      ElevatedButton(
                        onPressed: () {
                          LocalStorage.setSigned(true);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.main,
                            (route) => false,
                          );
                        },
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(50))),
                        child: Text(
                          LocaleKeys.continue_without_sign_in.tr(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                if(state.statusLogin.isInProgress)
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
