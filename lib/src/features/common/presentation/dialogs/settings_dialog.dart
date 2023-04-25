import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qaza_tracker/generated/locale_keys.g.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/core/local_source/local_storage.dart';

class SettingsDialog extends StatefulWidget {
  final String language;

  const SettingsDialog({required this.language, Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  String _languageCode = uz;

  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: uz,
      child: Text('Uzbek'),
    ),
    const DropdownMenuItem(
      value: en,
      child: Text('English'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _languageCode = widget.language;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
              value: _languageCode,
              items: items,
              underline: const SizedBox(),
              icon: const Icon(Icons.language),
              onChanged: (value) {
                if (value != _languageCode) {
                  context.setLocale(Locale(value ?? _languageCode));
                  setState(() {
                    _languageCode = value ?? 'uz';
                  });
                  LocalStorage.setLocale(_languageCode);
                }
              }),
          kHeight16,
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop('exit'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(32),
              side: const BorderSide(color: Colors.red),
            ),
            child: Text(
              LocaleKeys.exit.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
