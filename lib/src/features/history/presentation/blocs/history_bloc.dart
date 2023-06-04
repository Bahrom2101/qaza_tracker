import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/history/domain/models/history_entity.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(const HistoryState()) {
    on<InitialEvent>(_init);
    on<ChangeStatusEvent>(_onChangeStatus);
  }

  _init(InitialEvent event, Emitter<HistoryState> emit) async {
    add(const ChangeStatusEvent(FormzSubmissionStatus.inProgress));
    await getHistories(emit, event.salah);
  }

  Future _onChangeStatus(
      ChangeStatusEvent event, Emitter<HistoryState> emit) async {
    emit(state.copWith(
      statusFetch: event.status,
      message: event.message,
    ));
  }

  Future getHistories(Emitter<HistoryState> emit, String salah) async {
    await FirebaseFirestore.instance
        .collection(historiesCollection)
        .where('salah', isEqualTo: salah)
        .where('email', isEqualTo: LocalStorage.email)
        .orderBy('time', descending: true)
        .get()
        .then(
      (querySnapshot) {
        List<HistoryEntity> list = [];
        for (var docSnapshot in querySnapshot.docs) {
          list.add(HistoryEntity.fromJson(docSnapshot.data()));
        }
        emit(state.copWith(
            histories: list, statusFetch: FormzSubmissionStatus.success));
      },
      onError: (e) {
        emit(state.copWith(statusFetch: FormzSubmissionStatus.failure));
        debugPrint("Error completing: $e");
      },
    );
  }
}
