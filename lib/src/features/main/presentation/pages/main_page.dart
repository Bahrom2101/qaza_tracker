import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/routes/app_routes.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/user_entity.dart';
import 'package:qaza_tracker/src/features/main/presentation/blocs/main_bloc.dart';
import 'package:qaza_tracker/src/features/main/presentation/widgets/app_drawer.dart';
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
  bool locked = true;

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
                  onPressed: () => setState(() {
                    locked = !locked;
                  }),
                  icon: Icon(locked ? Icons.lock : Icons.lock_open_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.dateRange,
                    ).then((value) {
                      if (value is int) {
                        bloc.add(AddPeriodEvent(value + 1));
                      }
                    });
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            drawer: const AppDrawer(),
            body: Stack(
              children: [
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  itemBuilder: (_, index) {
                    var salahCount = getSalahCount(index, state.user);
                    return QazaItem(
                      locked: locked,
                      onTapPlus: () =>
                          bloc.add(ChangeValueEvent(index, salahCount + 1)),
                      onTapMinus: () =>
                          bloc.add(ChangeValueEvent(index, salahCount - 1)),
                      onChange: (value) =>
                          bloc.add(ChangeValueEvent(index, value)),
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
                if (state.statusFetch.isInProgress)
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

  String getSalahName(int index) => switch (index) {
        0 => 'fajr',
        1 => 'zuhr',
        2 => 'asr',
        3 => 'maghrib',
        4 => 'isha',
        5 => 'witr',
        _ => 'fajr',
      };

  int getSalahCount(int index, UserEntity user) => switch (index) {
        0 => user.fajr,
        1 => user.zuhr,
        2 => user.asr,
        3 => user.maghrib,
        4 => user.isha,
        5 => user.witr,
        _ => user.fajr,
      };

  @override
  bool get wantKeepAlive => true;
}
