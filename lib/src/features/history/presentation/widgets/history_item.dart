import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/config/themes/app_icons.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.amount,
    required this.time,
  });

  final int amount;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColorLight.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('${typeOfAction(amount).tr()} | '
                '${DateFormat(null, context.locale.languageCode).format(DateFormat(appDateFormat).parse(time))}'),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppIcons.undo,
              width: 16,
              height: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  String typeOfAction(int count) {
    if (count > 0) {
      return 'added';
    } else {
      return 'subtracted';
    }
  }
}
