import 'package:admiralui_flutter/admiralui_flutter.dart';
import 'package:admiralui_flutter/layout/layout_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';

/// The CalendarHorizontalView.
///
/// CalendarHorizontalView let users select a date, or a range of dates.
/// A horizontal calendar is a display of the month.
/// Switching between months and years is carried out using
/// the left and right buttons.
/// You can also switch between months using picker view.
/// You can create CalendarHorizontalView by specifying parameters:
/// DateTime? startDate - The start date of calendar.
/// DateTime? endDate - The end date of calendar.
/// DateTime? currentDate - The start date of calendar
/// String? locale - The day in the month which will be disaplyed.
/// String? datePickerButtonTitle - The button title of datepicker controls view
/// VoidCallback? onPageChanged - The closure that calls when
/// calendar page changes.
/// ValueChanged<List<DateTime?>>?? onChangedRangeDates - The notification of
/// changing start and end date.
/// CalendarHorizontalViewScheme? scheme - The visual scheme
/// of CalendarHorizontalView.
///
class CalendarHorizontalView extends StatefulWidget {
  const CalendarHorizontalView({
    this.startDate,
    this.endDate,
    this.currentDate,
    this.notActiveAfterDate,
    this.locale,
    this.datePickerButtonTitle,
    this.onPageChanged,
    this.onChangedRangeDates,
    this.selectedEndDate,
    this.selectedStartDate,
    this.scheme,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? currentDate;
  final DateTime? notActiveAfterDate;
  final String? locale;
  final String? datePickerButtonTitle;
  final VoidCallback? onPageChanged;
  final ValueChanged<List<DateTime?>>? onChangedRangeDates;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final CalendarHorizontalViewScheme? scheme;

  @override
  State<StatefulWidget> createState() => _CalendarHorizontalViewState();
}

class _CalendarHorizontalViewState extends State<CalendarHorizontalView> {
  late CalendarDatesDataSource dataSource;
  late bool isDatePickerActive = false;
  late CalendarHorizontalViewScheme scheme;
  late int currentIndex = 1;
  late String locale;

  final ValueNotifier<List<DateTime?>> _datesRangeNotifier =
      ValueNotifier<List<DateTime?>>(
    <DateTime?>[],
  );

  CalendartPageController infinityPageController = CalendartPageController(
    true,
    1,
    1.0,
  );

  @override
  void initState() {
    super.initState();
    currentIndex = 1;
    locale = widget.locale ?? 'ru';
    initializeDateFormatting(locale);
    dataSource = CalendarDatesDataSource(
      widget.startDate,
      widget.endDate,
      widget.currentDate,
      widget.notActiveAfterDate,
      _datesRangeNotifier,
      widget.selectedStartDate,
      widget.selectedEndDate,
    );

    _datesRangeNotifier.addListener(
      () {
        widget.onChangedRangeDates?.call(_datesRangeNotifier.value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppThemeProvider.of(context);
    scheme = widget.scheme ?? CalendarHorizontalViewScheme(theme: theme);
    return Column(
      children: <Widget>[
        CalendarControlsView(
          isDatePickerActive: isDatePickerActive,
          dataSource.currentDate ?? DateTime.now(),
          widget.datePickerButtonTitle ?? 'Выбрать',
          locale: widget.locale,
          onPressedPickerButton: () => _handlePickerButtonTap(),
          onPressedSlideLeft: () => _slideToIndex(currentIndex - 1),
          onPressedSlideRight: () => _slideToIndex(currentIndex + 1),
          onPressedSelect: () => _handlePickerButtonTap(),
        ),
        if (isDatePickerActive)
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: scheme.datePickerFont.toTextStyle(
                    scheme.datePickerTextColor.color(),
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: dataSource.currentDate ?? DateTime.now(),
                onDateTimeChanged: (DateTime val) {
                  setState(
                    () {
                      dataSource.currentDate = val;
                    },
                  );
                },
              ),
            ),
          ),
        if (!isDatePickerActive)
          CalendarWeekView(
            locale: locale,
            scheme: scheme.weekScheme,
          ),
        if (!isDatePickerActive)
          const SizedBox(
            height: LayoutGrid.doubleModule,
          ),
        if (!isDatePickerActive)
          Expanded(
            child: CalendarPageView(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    CalendarMonthView(
                      dataSource.monthList[index],
                      onTap: (CalendarDayItem dayItem) {
                        setState(
                          () {
                            dataSource.didTapAtDate(
                              dayItem.date,
                            );
                            _onPageChanged(currentIndex);
                          },
                        );
                      },
                      scheme: scheme.monthScheme,
                    ),
                  ],
                );
              },
              itemCount: 3,
              onPageChanged: (int index) {
                setState(() {
                  _onPageChanged(index);
                });
              },
              controller: infinityPageController,
            ),
          ),
      ],
    );
  }

  void _slideToIndex(int index) {
    infinityPageController.animateToPage(
      index,
      const Duration(milliseconds: 500),
      Curves.easeIn,
    );
  }

  void _onPageChanged(int index) {
    currentIndex = index;
    dataSource.updateMonthList(index);
    widget.onPageChanged?.call();
  }

  void _handlePickerButtonTap() {
    setState(
      () {
        isDatePickerActive = !isDatePickerActive;
        if (!isDatePickerActive) {
          dataSource.updateMonthListByCurrentDate();
        }
      },
    );
  }
}
