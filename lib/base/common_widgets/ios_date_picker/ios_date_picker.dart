import 'package:flutter/cupertino.dart';

import '../bar/accessory_bar.dart';

class IOSDatePickerView extends StatefulWidget {
  const IOSDatePickerView(
      {required this.mode,
      super.key,
      this.onDatePicked,
      this.initialDateTime,
      this.minimumDate,
      this.maximumDate});
  final Function(DateTime?)? onDatePicked;
  final CupertinoDatePickerMode mode;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  State<IOSDatePickerView> createState() => _IOSDatePickerViewState();
}

class _IOSDatePickerViewState extends State<IOSDatePickerView> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          AccessoryBar(
            title: '',
            onDonePressed: () {
              widget.onDatePicked?.call(selectedDateTime);
              Navigator.pop(context);
            },
            onCancelPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
                mode: widget.mode,
                initialDateTime: widget.initialDateTime,
                maximumDate: widget.maximumDate,
                minimumDate: widget.minimumDate,
                onDateTimeChanged: (val) {
                  selectedDateTime = val;
                }),
          ),
        ],
      ),
    );
  }
}
