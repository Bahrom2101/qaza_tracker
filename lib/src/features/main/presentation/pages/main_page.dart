import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';
import 'package:qaza_tracker/src/features/common/presentation/dialogs/settings_dialog.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/user_entity.dart';
import 'package:qaza_tracker/src/features/main/presentation/blocs/main_bloc.dart';
import 'package:qaza_tracker/src/features/main/presentation/widgets/qaza_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late MainBloc bloc;

  @override
  void initState() {
    bloc = MainBloc()..add(InitialEvent());
    super.initState();
  }

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppConsts.setSize(context);
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.lock),
                ),
                IconButton(
                  onPressed: () async {
                    final res = await Navigator.pushNamed(
                      context,
                      AppRoutes.dateRange,
                    );
                    if (res is int) {
                      bloc.add(AddPeriodEvent(res + 1));
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () async {
                    var prev = context.locale.languageCode;
                    showDialog<String>(
                      context: context,
                      builder: (context) => SettingsDialog(
                        language: prev,
                      ),
                    ).then((value) async {
                      if (value == 'exit') {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.login, (route) => false);
                        await FirebaseAuth.instance.signOut();
                        GoogleSignIn().signOut();
                        await LocalStorage.clearProfile();
                      }
                    });
                  },
                )
              ],
            ),
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              itemBuilder: (_, index) {
                var salahCount = getSalahCount(index, state.user);
                return QazaItem(
                  onTapPlus: () =>
                      bloc.add(ChangeValueEvent(index, salahCount + 1)),
                  onTapMinus: () =>
                      bloc.add(ChangeValueEvent(index, salahCount - 1)),
                  onChange: (value) => bloc.add(ChangeValueEvent(index, value)),
                  width: AppConsts.size.width,
                  name: getSalahName(index).tr(),
                  count: salahCount,
                );
              },
              shrinkWrap: true,
              separatorBuilder: (_, index) {
                return const SizedBox(height: 12);
              },
              itemCount: 6,
            ),
          );
        },
      ),
    );
  }

  String getSalahName(int index) {
    switch (index) {
      case 0:
        return 'fajr';
      case 1:
        return 'zuhr';
      case 2:
        return 'asr';
      case 3:
        return 'maghrib';
      case 4:
        return 'isha';
      case 5:
        return 'witr';
      default:
        return 'fajr';
    }
  }

  int getSalahCount(int index, UserEntity user) {
    switch (index) {
      case 0:
        return user.fajr;
      case 1:
        return user.zuhr;
      case 2:
        return user.asr;
      case 3:
        return user.maghrib;
      case 4:
        return user.isha;
      case 5:
        return user.witr;
      default:
        return user.fajr;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
