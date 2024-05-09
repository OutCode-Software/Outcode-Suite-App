import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/app_styles.dart';
import '../buttons/app_button.dart';

class DateRangeSelectionView extends StatelessWidget {
  DateRangeSelectionView(
      {required this.selectedDates, this.onSelectedDatesChanged, super.key});
  final List<DateTime> selectedDates;
  final Function(List<DateTime>)? onSelectedDatesChanged;
  final DateRangePickerController _calendarController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55),
      child: DecoratedBox(
          decoration: AppStyles.bottomSheetBoxDecoration(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'SelectDate'.localized,
                  style: AppStyles.boldMedium(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SfDateRangePicker(
                  controller: _calendarController,
                  initialSelectedDates: selectedDates,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange:
                      PickerDateRange(selectedDates.first, selectedDates.last),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: 'Cancel'.localized,
                        onClick: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: context.colorScheme.primary,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: AppButton(
                        title: 'Filter'.localized,
                        onClick: () {
                          _onSelectionChanged
                              .call(_calendarController.selectedRange);
                          Navigator.pop(context);
                        },
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  void _onSelectionChanged(PickerDateRange? args) {
    final dates = <DateTime>[];
    if (args == null) {
      return;
    }
    if (args.startDate == null) {
      return;
    }
    dates
      ..add(args.startDate!)
      ..add(args.endDate ?? args.startDate!);
    onSelectedDatesChanged?.call(dates);
  }
}
