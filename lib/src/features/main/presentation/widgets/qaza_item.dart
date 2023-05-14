import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';
import 'package:qaza_tracker/src/features/common/presentation/components/text_inputs/app_text_input.dart';

class QazaItem extends StatefulWidget {
  const QazaItem({
    Key? key,
    required this.onTapPlus,
    required this.onTapMinus,
    required this.width,
    required this.name,
    required this.count,
    required this.onChange,
    required this.locked,
  }) : super(key: key);

  final VoidCallback onTapPlus;
  final VoidCallback onTapMinus;
  final double width;
  final String name;
  final int count;
  final Function(int) onChange;
  final bool locked;

  @override
  State<QazaItem> createState() => _QazaItemState();
}

class _QazaItemState extends State<QazaItem> {
  final controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {
        _focused = _focus.hasFocus;
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
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: widget.locked ? null : widget.onTapMinus,
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
              Expanded(
                child: AppTextInput(
                    readOnly: widget.locked,
                    focus: _focus,
                    controller: controller..text = widget.count.toString(),
                    focused: _focused,
                    onTapSuffix: () {
                      widget.onChange(int.parse(controller.text));
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    borderRadius: kBorderRadius),
              ),
              kWidth8,
              OutlinedButton(
                onPressed: widget.locked ? null : widget.onTapPlus,
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
