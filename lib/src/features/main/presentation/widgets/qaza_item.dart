import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';

class QazaItem extends StatefulWidget {
  const QazaItem({
    Key? key,
    required this.onTapPlus,
    required this.onTapMinus,
    required this.width,
    required this.name,
    required this.count,
    required this.onChange,
  }) : super(key: key);

  final VoidCallback onTapPlus;
  final VoidCallback onTapMinus;
  final double width;
  final String name;
  final int count;
  final Function(int) onChange;

  @override
  State<QazaItem> createState() => _QazaItemState();
}

class _QazaItemState extends State<QazaItem> {
  final controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _focused = false;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    _focus.addListener(() {
      setState(() {
        _focused = _focus.hasFocus;
        if (_focus.hasFocus) {
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColorLight.withOpacity(0.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.name,
            style: const TextStyle(fontSize: 16),
          ),
          kHeight8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: widget.onTapMinus,
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  minimumSize: const Size(45, 45),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
              kWidth8,
              SizedBox(
                width: widget.width - 200,
                child: TextFormField(
                  // initialValue: widget.count.toString(),
                  focusNode: _focus,
                  controller: controller..text = widget.count.toString(),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'\d'))
                  ],
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    suffixIcon: _focused
                        ? Transform.scale(
                            scale: 0.7,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.lightBlue.shade200,
                                shape: const CircleBorder(),
                              ),
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                widget.onChange(int.parse(controller.text));
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          )
                        : null,
                    contentPadding: const EdgeInsets.all(10),
                    focusColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                  ),
                ),
              ),
              kWidth8,
              OutlinedButton(
                onPressed: widget.onTapPlus,
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  minimumSize: const Size(45, 45),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
