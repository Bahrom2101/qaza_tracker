import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/config/themes/app_icons.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/login/presentation/blocs/login_bloc.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _languageCode = uz;
  late LoginBloc bloc;

  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: en,
      child: Text('English'),
    ),
    const DropdownMenuItem(
      value: uz,
      child: Text("O'zbek"),
    ),
    const DropdownMenuItem(
      value: ru,
      child: Text('Русский'),
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
            body: Padding(
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
                      icon: const Icon(Icons.language),
                      onChanged: (value) {
                        if (value != _languageCode) {
                          context.setLocale(Locale(value ?? _languageCode));
                          setState(() {
                            _languageCode = value ?? 'en';
                          });
                          LocalStorage.setLocale(_languageCode);
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bloc.add(const ChangeStatusEvent(
                          FormzSubmissionStatus.inProgress));
                      _signInGoogle();
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
          );
        },
      ),
    );
  }

  void _signInGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        var credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        var userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        var users = FirebaseFirestore.instance.collection(usersCollection);
        var documentSnapshot =
            await users.doc(userCredential.user?.email ?? '').get();
        if (documentSnapshot.data() == null) {
          users.doc(userCredential.user?.email ?? '').set(UserModel(
                email: userCredential.user?.email ?? '',
                fajr: 0,
                zuhr: 0,
                asr: 0,
                maghrib: 0,
                isha: 0,
                witr: 0,
              ).toJson());
        }
        LocalStorage.setEmail(userCredential.user?.email ?? '');
        LocalStorage.setSigned(true);
        bloc.add(const ChangeStatusEvent(FormzSubmissionStatus.success));
      } else {
        bloc.add(ChangeStatusEvent(
          FormzSubmissionStatus.failure,
          LocaleKeys.error_occurred.tr(),
        ));
      }
    } catch (e) {
      bloc.add(ChangeStatusEvent(
        FormzSubmissionStatus.failure,
        LocaleKeys.error_occurred.tr(),
      ));
    }
  }
}
