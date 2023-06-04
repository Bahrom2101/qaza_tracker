import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/history/data/models/history_model.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<InitialEvent>(_init);
    on<ChangeStatusEvent>(_onChangeStatus);
    on<ChangeValueEvent>(_onChangeValue);
    on<AddPeriodEvent>(_onAddPeriod);
    on<UpdateEvent>(_onUpdate);
  }

  _init(InitialEvent event, Emitter<MainState> emit) async {
    add(const ChangeStatusEvent(FormzSubmissionStatus.inProgress));
    await getUser(emit);
    add(const ChangeStatusEvent(FormzSubmissionStatus.success));
  }

  Future getUser(Emitter<MainState> emit) async {
    UserModel user;
    if (LocalStorage.email.isEmpty) {
      user = LocalStorage.user;
    } else {
      var users = FirebaseFirestore.instance.collection(usersCollection);
      var documentSnapshot = await users.doc(LocalStorage.email).get();
      Map<String, dynamic>? data = documentSnapshot.data();
      if (data != null) {
        user = UserModel.fromJson(data);
      } else {
        user = const UserModel();
      }
    }
    LocalStorage.setUser(user);
    emit(state.copWith(user: user));
  }

  Future _onChangeStatus(
      ChangeStatusEvent event, Emitter<MainState> emit) async {
    emit(state.copWith(
      statusFetch: event.status,
      message: event.message,
    ));
  }

  Future _onChangeValue(ChangeValueEvent event, Emitter<MainState> emit) async {
    var time = DateFormat(appDateFormat).format(DateTime.now());
    var user = state.user.copWith(
      index: event.index,
      value: event.value,
      salah: event.salah,
      amount: event.amount,
      time: time,
    );
    if (LocalStorage.email.isNotEmpty) {
      var uuid = const Uuid();
      var userCollection =
          FirebaseFirestore.instance.collection(usersCollection);
      var historyCollection = FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(LocalStorage.email)
          .collection(historiesCollection);
      var docUser = userCollection.doc(LocalStorage.email);
      var docHistory = historyCollection.doc(uuid.v4());
      docUser.update(user.toJson());
      docHistory.set(HistoryModel(
        salah: event.salah,
        email: LocalStorage.email,
        amount: event.amount,
        time: time,
      ).toJson());
    }
    LocalStorage.setUser(user);
    emit(state.copWith(user: user));
  }

  _onAddPeriod(AddPeriodEvent event, Emitter<MainState> emit) {
    var userEntity = UserModel(
      email: state.user.email,
      fajr: state.user.fajr + event.days,
      zuhr: state.user.zuhr + event.days,
      asr: state.user.asr + event.days,
      maghrib: state.user.maghrib + event.days,
      isha: state.user.isha + event.days,
      witr: state.user.witr + event.days,
    );
    if (LocalStorage.email.isNotEmpty) {
      var users = FirebaseFirestore.instance.collection(usersCollection);
      users.doc(LocalStorage.email).update(userEntity.toJson());
    }
    LocalStorage.setUser(userEntity);
    emit(state.copWith(user: userEntity));
  }

  _onUpdate(UpdateEvent event, Emitter<MainState> emit) {
    emit(state.copWith(forUpdate: state.forUpdate + 1));
  }
}
