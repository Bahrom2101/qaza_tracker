import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:qaza_tracker/src/features/history/presentation/blocs/history_bloc.dart';
import 'package:qaza_tracker/src/features/history/presentation/widgets/history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryBloc bloc;

  @override
  void initState() {
    bloc = HistoryBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final salah = ModalRoute.of(context)!.settings.arguments as String;
    bloc.add(InitialEvent(salah));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  itemCount: state.histories.length,
                  itemBuilder: (context, index) => HistoryItem(
                    amount: state.histories[index].amount,
                    time: state.histories[index].time,
                  ),
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 12);
                  },
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
}
