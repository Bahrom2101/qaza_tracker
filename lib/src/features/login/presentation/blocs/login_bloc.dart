import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<ChangeStatusEvent>(_onChangeStatus);
  }

  Future _onChangeStatus(
      ChangeStatusEvent event, Emitter<LoginState> emit) async {
    emit(state.copWith(statusLogin: event.status, message: event.message));
  }
}
