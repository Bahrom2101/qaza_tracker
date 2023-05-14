import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<ChangeStatusEvent>(_onChangeStatus);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<AppleSignInEvent>(_onAppleSignIn);
  }

  Future _onChangeStatus(
      ChangeStatusEvent event, Emitter<LoginState> emit) async {
    emit(state.copWith(statusLogin: event.status, message: event.message));
  }

  _onGoogleSignIn(GoogleSignInEvent event, Emitter<LoginState> emit) async {
    add(const ChangeStatusEvent(FormzSubmissionStatus.inProgress));
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
        LocalStorage.setImage(userCredential.user?.photoURL ?? '');
        LocalStorage.setSigned(true);
        add(const ChangeStatusEvent(FormzSubmissionStatus.success));
      } else {
        add(ChangeStatusEvent(
          FormzSubmissionStatus.failure,
          LocaleKeys.error_occurred.tr(),
        ));
      }
    } catch (e) {
      add(ChangeStatusEvent(
        FormzSubmissionStatus.failure,
        LocaleKeys.error_occurred.tr(),
      ));
    }
  }

  _onAppleSignIn(AppleSignInEvent event, Emitter<LoginState> emit) async {
    add(const ChangeStatusEvent(FormzSubmissionStatus.inProgress));
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
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
      LocalStorage.setImage(userCredential.user?.photoURL ?? '');
      LocalStorage.setSigned(true);
      add(const ChangeStatusEvent(FormzSubmissionStatus.success));
    } catch (e) {
      add(ChangeStatusEvent(
        FormzSubmissionStatus.failure,
        LocaleKeys.error_occurred.tr(),
      ));
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
