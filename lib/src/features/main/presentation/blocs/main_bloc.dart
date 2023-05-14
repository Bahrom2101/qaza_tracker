import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/main/data/models/user_model.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/user_entity.dart';

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
    emit(state.copWith(
      user: user,
      statusFetch: FormzSubmissionStatus.success,
    ));
  }

  Future _onChangeStatus(
      ChangeStatusEvent event, Emitter<MainState> emit) async {
    emit(state.copWith(
      statusFetch: event.status,
      message: event.message,
    ));
  }

  Future _onChangeValue(ChangeValueEvent event, Emitter<MainState> emit) async {
    var userEntity = state.user.copWith(
      index: event.index,
      value: event.value,
    );
    if (LocalStorage.email.isNotEmpty) {
      var users = FirebaseFirestore.instance.collection(usersCollection);
      users.doc(LocalStorage.email).update(userEntity.toJson());
    }
    LocalStorage.setUser(userEntity);
    emit(state.copWith(user: userEntity));
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
