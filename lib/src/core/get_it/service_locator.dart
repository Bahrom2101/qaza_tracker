import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  // serviceLocator.registerLazySingleton(() => DioSettings());
}

Future resetLocator() async {
  await serviceLocator.reset();
  await setupLocator();
}
