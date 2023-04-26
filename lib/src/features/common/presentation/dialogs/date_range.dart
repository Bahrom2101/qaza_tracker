import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/features/common/presentation/components/text_inputs/app_text_input.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateRange extends StatefulWidget {
  const CustomDateRange({
    Key? key,
  }) : super(key: key);

  @override
  CustomDateRangeState createState() => CustomDateRangeState();
}

class CustomDateRangeState extends State<CustomDateRange> {
  DateTime? start;
  DateTime? end;
  var dayStart = TextEditingController();
  var monthStart = TextEditingController();
  var yearStart = TextEditingController();
  var dayEnd = TextEditingController();
  var monthEnd = TextEditingController();
  var yearEnd = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        start = args.value.startDate;
        end = args.value.endDate;
      }
      if (start != null) {
        dayStart.text = start!.day.toString();
        monthStart.text = start!.month.toString();
        yearStart.text = start!.year.toString();
      }
      if (end != null) {
        dayEnd.text = end!.day.toString();
        monthEnd.text = end!.month.toString();
        yearEnd.text = end!.year.toString();
      }
    });
  }

  bool get isEnable => start != null && end != null ||
          dayStart.text.isNotEmpty &&
              monthStart.text.isNotEmpty &&
              yearStart.text.isNotEmpty &&
              dayEnd.text.isNotEmpty &&
              monthEnd.text.isNotEmpty &&
              yearEnd.text.isNotEmpty
      ? true
      : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              start = DateTime(
                int.parse(yearStart.text),
                int.parse(monthStart.text),
                int.parse(dayStart.text),
              );
              end = DateTime(
                int.parse(yearEnd.text),
                int.parse(monthEnd.text),
                int.parse(dayEnd.text),
              );
              if (end!.difference(start!).inDays >= 0) {
                Navigator.of(context).pop(end!.difference(start!).inDays);
              }
            },
            child: Text(
              LocaleKeys.save.tr(),
              style: TextStyle(
                color: isEnable
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          kWidth8,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight16,
                  Text(
                    LocaleKeys.add_period.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  kHeight24,
                  Text('${LocaleKeys.start_date.tr()}:'),
                  kHeight4,
                  Row(
                    children: [
                      Expanded(
                        child: AppTextInput(
                          controller: dayStart,
                          borderRadius: 10,
                          hintText: LocaleKeys.day.tr(),
                          maxLength: 2,
                        ),
                      ),
                      kWidth16,
                      Expanded(
                        child: AppTextInput(
                          borderRadius: 10,
                          hintText: LocaleKeys.month.tr(),
                          text: start?.month.toString(),
                          maxLength: 2,
                        ),
                      ),
                      kWidth16,
                      Expanded(
                        child: AppTextInput(
                          borderRadius: 10,
                          hintText: LocaleKeys.year.tr(),
                          text: start?.year.toString(),
                          maxLength: 4,
                        ),
                      ),
                    ],
                  ),
                  kHeight24,
                  Text('${LocaleKeys.end_date.tr()}:'),
                  kHeight4,
                  Row(
                    children: [
                      Expanded(
                        child: AppTextInput(
                          borderRadius: 10,
                          hintText: LocaleKeys.day.tr(),
                          text: end?.day.toString(),
                          maxLength: 2,
                        ),
                      ),
                      kWidth16,
                      Expanded(
                        child: AppTextInput(
                          borderRadius: 10,
                          hintText: LocaleKeys.month.tr(),
                          text: end?.month.toString(),
                          maxLength: 2,
                        ),
                      ),
                      kWidth16,
                      Expanded(
                        child: AppTextInput(
                          borderRadius: 10,
                          hintText: LocaleKeys.year.tr(),
                          text: end?.year.toString(),
                          maxLength: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kHeight32,
              SfDateRangePicker(
                navigationMode: DateRangePickerNavigationMode.scroll,
                onSelectionChanged: _onSelectionChanged,
                maxDate: DateTime.now(),
                minDate: DateTime(DateTime.now().year - 100),
                selectionMode: DateRangePickerSelectionMode.range,
              )
            ],
          ),
        ),
      ),
    );
  }
}
