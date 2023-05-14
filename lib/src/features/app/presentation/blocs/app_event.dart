part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class ChangeThemeModeEvent extends AppEvent {
  final String mode;

  const ChangeThemeModeEvent(this.mode);
}