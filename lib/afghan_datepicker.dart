library afghan_datepicker;

import 'package:flutter/material.dart';
import 'package:afghan_datepicker/utils/afghani.dart';
import 'package:afghan_datepicker/utils/shamsi.dart';
import 'package:afghan_datepicker/utils/translator.dart';
import 'package:afghan_datepicker/utils/shared.dart';

class AfghanDatePicker extends StatefulWidget {
  final bool rangeSelector;
  final TextEditingController controller;

  final int yearSelectionAnimationDuration;
  final Curve yearSelectionAnimationCurve;
  final int monthSelectionAnimationDuration;
  final Curve monthSelectionAnimationCurve;
  final String headerTodayCaption;
  final Icon headerTodayIcon;
  final Color yearSelectionBackgroundColor;
  final Color yearSelectionFontColor;
  final Color yearSelectionHighlightBackgroundColor;
  final Color yearSelectionHighlightFontColor;
  final Color monthSelectionBackgroundColor;
  final Color monthSelectionFontColor;
  final Color monthSelectionHighlightBackgroundColor;
  final Color monthSelectionHighlightFontColor;
  final Color weekCaptionsBackgroundColor;
  final Color weekCaptionsFontColor;
  final Color headerBackgroundColor;
  final Color headerFontColor;
  final Color daysBackgroundColor;
  final Color daysFontColor;
  final Color currentDayBackgroundColor;
  final Color currentDayFontColor;
  final Color selectedDayBackgroundColor;
  final Color selectedDayFontColor;
  final Color headerTodayBackgroundColor;
  final Color disabledDayBackgroundColor;
  final Color disabledDayFontColor;
  final String locale;

  AfghanDatePicker(
      {this.yearSelectionAnimationDuration,
      this.yearSelectionAnimationCurve,
      this.yearSelectionHighlightBackgroundColor,
      this.yearSelectionHighlightFontColor,
      this.monthSelectionAnimationDuration,
      this.monthSelectionAnimationCurve,
      this.monthSelectionHighlightBackgroundColor,
      this.monthSelectionHighlightFontColor,
      this.yearSelectionBackgroundColor,
      this.yearSelectionFontColor,
      this.monthSelectionBackgroundColor,
      this.monthSelectionFontColor,
      this.weekCaptionsBackgroundColor,
      this.weekCaptionsFontColor,
      this.headerBackgroundColor,
      this.headerFontColor,
      this.daysBackgroundColor,
      this.daysFontColor,
      this.currentDayBackgroundColor,
      this.currentDayFontColor,
      this.selectedDayBackgroundColor,
      this.selectedDayFontColor,
      this.headerTodayBackgroundColor,
      this.disabledDayBackgroundColor,
      this.disabledDayFontColor,
      this.controller,
      this.rangeSelector: false,
      this.headerTodayCaption,
      this.headerTodayIcon,
      this.locale = "fa"});

  @override
  _AfghanDatePickerState createState() => _AfghanDatePickerState();
}

class _AfghanDatePickerState extends State<AfghanDatePicker>
    with TickerProviderStateMixin {
  int _yearSelectionAnimationDuration;
  Curve _yearSelectionAnimationCurve;
  int _monthSelectionAnimationDuration;
  Curve _monthSelectionAnimationCurve;
  Color _yearSelectionBackgroundColor;
  Color _yearSelectionFontColor;
  Color _yearSelectionHighlightBackgroundColor;
  Color _yearSelectionHighlightFontColor;
  Color _monthSelectionBackgroundColor;
  Color _monthSelectionFontColor;
  Color _monthSelectionHighlightBackgroundColor;
  Color _monthSelectionHighlightFontColor;
  Color _weekCaptionsBackgroundColor;
  Color _weekCaptionsFontColor;
  Color _headerBackgroundColor;
  Color _headerFontColor;
  Color _daysBackgroundColor;
  Color _daysFontColor;
  Color _currentDayBackgroundColor;
  Color _currentDayFontColor;
  Color _selectedDayBackgroundColor;
  Color _selectedDayFontColor;
  Color _headerTodayBackgroundColor;
  Color _disabledDayBackgroundColor;
  Color _disabledDayFontColor;
  String _headerTodayCaption;
  Icon _headerTodayIcon;

  final AfghaniDate currentDate = AfghaniDate.now();
  final AfghaniDate startDate =
      AfghaniDate.fromDateTime(DateTime(1925, 3, 21)); // 1320/1/1
  final List<Map<String, dynamic>> pages = [];
  final List<int> months = [];
  final List<int> years = [];

  AfghaniDate inputSelectedDate;
  AfghaniDate rangeStartDate;
  AfghaniDate rangeFinishDate;

  double bottomSheetHeight = 325;
  int selectedPageIndex;
  int todayPageIndex;

  int datePickerCurrentMonth = 1;
  int datePickerCurrentYear = 1;

  ScrollController displayYearsController;
  ScrollController displayMonthsController;
  PageController datePickerController;

  AnimationController yearAnimationController;
  AnimationController monthAnimationController;

  inputStringToAfghani() {
    if (widget.controller.text != null &&
        widget.controller.text.toString().isNotEmpty) {
      if (widget.rangeSelector == true) {
        List<String> datesList = widget.controller.text.toString().split(" - ");
        if (datesList.length == 2) {
          List<String> startDate = datesList[0].split("/");
          rangeStartDate = inputSelectedDate = AfghaniDate(
              int.parse(startDate[0]),
              int.parse(startDate[1]),
              int.parse(startDate[2]));

          List<String> finishDate = datesList[1].split("/");
          rangeFinishDate = AfghaniDate(int.parse(finishDate[0]),
              int.parse(finishDate[1]), int.parse(finishDate[2]));
        }
      } else {
        List<String> sdl = widget.controller.text.toString().split("/");
        inputSelectedDate = AfghaniDate(
            int.parse(sdl[0]), int.parse(sdl[1]), int.parse(sdl[2]));
      }
    } else {
      inputSelectedDate = AfghaniDate.now();
    }
  }

  void initializeParams() {
    _yearSelectionAnimationDuration =
        (widget.yearSelectionAnimationDuration != null)
            ? widget.yearSelectionAnimationDuration
            : 400;
    _yearSelectionAnimationCurve = (widget.yearSelectionAnimationCurve != null)
        ? widget.yearSelectionAnimationCurve
        : Curves.elasticOut;
    _monthSelectionAnimationDuration =
        (widget.monthSelectionAnimationDuration != null)
            ? widget.monthSelectionAnimationDuration
            : 400;
    _monthSelectionAnimationCurve =
        (widget.monthSelectionAnimationCurve != null)
            ? widget.monthSelectionAnimationCurve
            : Curves.elasticOut;
    _yearSelectionBackgroundColor =
        (widget.yearSelectionBackgroundColor != null)
            ? widget.yearSelectionBackgroundColor
            : Colors.white;
    _yearSelectionFontColor = (widget.yearSelectionFontColor != null)
        ? widget.yearSelectionFontColor
        : Colors.black;
    _yearSelectionHighlightBackgroundColor =
        (widget.yearSelectionHighlightBackgroundColor != null)
            ? widget.yearSelectionHighlightBackgroundColor
            : Colors.blue[100];
    _yearSelectionHighlightFontColor =
        (widget.yearSelectionHighlightFontColor != null)
            ? widget.yearSelectionHighlightFontColor
            : Colors.white;
    _monthSelectionBackgroundColor =
        (widget.monthSelectionBackgroundColor != null)
            ? widget.monthSelectionBackgroundColor
            : Colors.white;
    _monthSelectionFontColor = (widget.monthSelectionFontColor != null)
        ? widget.monthSelectionFontColor
        : Colors.black;
    _monthSelectionHighlightBackgroundColor =
        (widget.monthSelectionHighlightBackgroundColor != null)
            ? widget.monthSelectionHighlightBackgroundColor
            : Colors.blue[100];
    _monthSelectionHighlightFontColor =
        (widget.monthSelectionHighlightFontColor != null)
            ? widget.monthSelectionHighlightFontColor
            : Colors.white;
    _weekCaptionsBackgroundColor = (widget.weekCaptionsBackgroundColor != null)
        ? widget.weekCaptionsBackgroundColor
        : Colors.blue;
    _weekCaptionsFontColor = (widget.weekCaptionsFontColor != null)
        ? widget.weekCaptionsFontColor
        : Colors.white;
    _headerBackgroundColor = (widget.headerBackgroundColor != null)
        ? widget.headerBackgroundColor
        : Colors.white;
    _headerFontColor = (widget.headerFontColor != null)
        ? widget.headerFontColor
        : Colors.black;
    _daysBackgroundColor = (widget.daysBackgroundColor != null)
        ? widget.daysBackgroundColor
        : Colors.transparent;
    _daysFontColor =
        (widget.daysFontColor != null) ? widget.daysFontColor : Colors.black87;
    _currentDayBackgroundColor = (widget.currentDayBackgroundColor != null)
        ? widget.currentDayBackgroundColor
        : Colors.lightGreen.withOpacity(0.15);
    _currentDayFontColor = (widget.currentDayFontColor != null)
        ? widget.currentDayFontColor
        : Colors.black;
    _selectedDayBackgroundColor = (widget.selectedDayBackgroundColor != null)
        ? widget.selectedDayBackgroundColor
        : Colors.lightBlueAccent.withOpacity(0.15);
    _selectedDayFontColor = (widget.selectedDayFontColor != null)
        ? widget.selectedDayFontColor
        : Colors.black87;
    _headerTodayBackgroundColor = (widget.headerTodayBackgroundColor != null)
        ? widget.headerTodayBackgroundColor
        : Colors.brown.withOpacity(0.1);
    _disabledDayBackgroundColor = (widget.disabledDayBackgroundColor != null)
        ? widget.disabledDayBackgroundColor
        : Colors.black.withOpacity(.03);
    _disabledDayFontColor = (widget.disabledDayFontColor != null)
        ? widget.disabledDayFontColor
        : Colors.black.withOpacity(.35);
    _headerTodayIcon = (widget.headerTodayIcon != null)
        ? widget.headerTodayIcon
        : Icon(
            Icons.date_range,
            color: Colors.green,
          );
    _headerTodayCaption = (widget.headerTodayCaption != null)
        ? widget.headerTodayCaption
        : widget.locale == 'ps' ? 'نن ورځ' : 'امروز';
  }

  @override
  void initState() {
    // initialize parameters if they exist or use default options
    initializeParams();

    // change TextField input to a afghani data-type, if there is no input, then current date is used
    inputStringToAfghani();

    // set current month and year of the datepicker to selected input string
    datePickerCurrentMonth = inputSelectedDate.month;
    datePickerCurrentYear = inputSelectedDate.year;

    // using this index to determine the position of first day of month in week. for example ( may be 1st day of next month is monday )
    int firstDayOfMonthIndex = 0;

    // this variable is used to jump or animate to pages by using their index
    int pageIndex = 0;

    // to store number of days of previous month ( this can help to understand the firstDayOfMonthIndex )
    // initialize is 0 because we don't have any previous month
    int previousMonthDays = 0;

    // loop through years and months and add them inside `pages` ==>  List<Map<String, dynamic>>
    for (int year = startDate.year; year <= (currentDate.year + 100); year++) {
      // adding year to years list to have length of years
      years.add(year);

      for (int month = 1; month <= 12; month++) {
        // adding month to months list to have length of months
        months.add(month);

        // check if year and month of loops is equal to user input date. if yes, we store this page index as selected page index
        if (year == inputSelectedDate.year && month == inputSelectedDate.month)
          selectedPageIndex = pageIndex;

        // check if year and month of loops is equal to current datetime. if yes, we store this page index as today page index
        if (year == currentDate.year && month == currentDate.month)
          todayPageIndex = pageIndex;

        // by using afghani package, calculate the number of days of current month
        int shamsiDaysOfMonth = shamsiDaysInMonth(month, year);

        // by adding (shamsiDaysOfMonth + firstDayOfMonthInWeek) and % it to 7 ( number of days in a week )
        // we can find out what is the position of current month's first day inside the week. ( sat, sun, mon, ... )
        // at first, firstDayOfMonthInWeek = 0 so the first day of week is the first day of current month
        // firstDayOfMonthInWeek = 0 is important, because the starting date is 1925, 3, 21 which the first day of month is saturday
        // in farsi calendar, Saturday ( شنبه ) is the first day of week
        int firstDayOfMonthInWeek = firstDayOfMonthIndex % 7;

        // add current page to pages list
        pages.add({
          'Y': year,
          'M': month,
          'DIM': shamsiDaysOfMonth, // Days In Month
          'FDIW': firstDayOfMonthInWeek, // First Day of Month In Week
          'PMDIM': previousMonthDays // Previous Month Days In Month
        });

        pageIndex++;

        // we set current month's days as `previousMonthDays` for the next loop to store it in the next page
        previousMonthDays = shamsiDaysOfMonth;

        // calculating first day of month for the next loop round
        firstDayOfMonthIndex = (shamsiDaysOfMonth + firstDayOfMonthInWeek) % 7;
      }
    }

    // the whole datepicker is a `PageView` and so we define a controller for it
    datePickerController = PageController(initialPage: selectedPageIndex);

    // year animation controller
    yearAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _yearSelectionAnimationDuration));

    // month animation controller
    monthAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _monthSelectionAnimationDuration));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // in order to hide year and month little-dialogs when tapping anywhere on datepicker, we wrap our datepicker by a GestureDetector
    // and inside it's onTap reset both year and month animations
    return Material(
      child: GestureDetector(
        onTap: () {
          yearAnimationController.reset();
          monthAnimationController.reset();
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: bottomSheetHeight,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: PageView.builder(
                          onPageChanged: (index) {
                            // if page is changed, swiped, we change datepicker current month and year and chaning datepicker state
                            Map<String, dynamic> pageInfo = pages[index];
                            datePickerCurrentMonth = pageInfo['M'];
                            datePickerCurrentYear = pageInfo['Y'];
                            setState(() {});
                          },
                          controller: datePickerController,

                          // the number of pages
                          itemCount: pages.length,

                          // building pages
                          itemBuilder: (BuildContext context, int index) {
                            // getting page info from pages list by it's index
                            Map<String, dynamic> pageInfo = pages[index];

                            // store the parts of page inside a list of widgets
                            List<Widget> datePicker = [];

                            // in most cases the number of rows of days for each page is 7
                            // but in some cases, if the starting day of current month is ( thu, fri )
                            // the number of rows may be 8. so we check it here
                            int viewPortDays = 35;
                            if ((pageInfo['DIM'] + pageInfo['FDIW']) > 35) {
                              viewPortDays = 42;
                            }

                            // rendering days row by row.
                            // first row starts by 0 index
                            int previousRowDayNumber = 0;
                            for (int row = 1; row <= (viewPortDays / 7); row++) {
                              List<Widget> rowWidgets = [];

                              // if it is first row, then we need to display headers before days rows above current row of days,
                              // and also display previous month days before current month starting day
                              if (row == 1) {
                                datePicker.addAll([
                                  _datePickerPageHeader(pageInfo),
                                  _datePickerPageWeekCaptions(),
                                ]);

                                // displaying previous month days
                                for (int daysBefore = (pageInfo['PMDIM'] -
                                        pageInfo['FDIW'] +
                                        1);
                                    daysBefore <= pageInfo['PMDIM'];
                                    daysBefore++) {
                                  rowWidgets.add(_dayBlock(
                                      day: daysBefore,
                                      otherMonthDay: true,
                                      pageInfo: pageInfo));
                                }

                                // displaying current month days in this row
                                for (int firstRowDays = 1;
                                    firstRowDays <= (7 - pageInfo['FDIW']);
                                    firstRowDays++) {
                                  rowWidgets.add(_dayBlock(
                                      day: firstRowDays, pageInfo: pageInfo));
                                }

                                previousRowDayNumber = (7 - pageInfo['FDIW']);

                                // if this row is the last row
                              } else if (row == (viewPortDays / 7)) {
                                // display days of current row
                                for (int lastRowDays = previousRowDayNumber + 1;
                                    lastRowDays <= pageInfo['DIM'];
                                    lastRowDays++) {
                                  rowWidgets.add(_dayBlock(
                                      day: lastRowDays, pageInfo: pageInfo));
                                }

                                // display days of next month right after the last day of current month
                                for (int daysAfter = viewPortDays;
                                    daysAfter >
                                        (pageInfo['DIM'] + pageInfo['FDIW']);
                                    daysAfter--) {
                                  rowWidgets.add(_dayBlock(
                                      day: viewPortDays - daysAfter + 1,
                                      otherMonthDay: true,
                                      pageInfo: pageInfo));
                                }

                                // if this row is not first and last...
                              } else {
                                // displaying days of current row
                                for (int dayRow = previousRowDayNumber + 1;
                                    dayRow <= (previousRowDayNumber + 7);
                                    dayRow++) {
                                  rowWidgets.add(
                                      _dayBlock(day: dayRow, pageInfo: pageInfo));
                                }

                                previousRowDayNumber += 7;
                              }

                              datePicker.add(Row(
                                children: rowWidgets,
                              ));
                            }

                            return Column(
                              children: datePicker,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),

                // years dialog widget
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                        parent: yearAnimationController,
                        curve: Interval(0.0, 1.0,
                            curve: _yearSelectionAnimationCurve)),
                    child: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                      child: displayYears(),
                    ),
                  ),
                ),

                // month dialog widget
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                        parent: monthAnimationController,
                        curve: Interval(0.0, 1.0,
                            curve: _monthSelectionAnimationCurve)),
                    child: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                      child: displayMonths(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // this function displays each day as a block or cell
  Widget _dayBlock({int day, bool otherMonthDay = false, pageInfo}) {
    Color color = _daysBackgroundColor;
    Color fontColor = _daysFontColor;
    AfghaniDate dayBlockDateTime =
        AfghaniDate(datePickerCurrentYear, datePickerCurrentMonth, day);

    // if datepicker type is `range` and starting day is selected, then all previous days should be disabled
    bool rangeModeTrueAndDayIsBeforeStart = false;
    if (rangeStartDate != null && rangeFinishDate == null) {
      if (dayBlockDateTime.toDateTime().isBefore(rangeStartDate.toDateTime())) {
        rangeModeTrueAndDayIsBeforeStart = true;
      }
    }

    // if current day is not a day of current month ( it belongs to previous or next month ) then it should be disabled
    if (otherMonthDay == true || rangeModeTrueAndDayIsBeforeStart == true) {
      color = _disabledDayBackgroundColor;
      fontColor = _disabledDayFontColor;
    } else {
      // if current day is belongs to current month and equals to current date , then change color and font to current date
      if (currentDate.day == day &&
          currentDate.month == datePickerCurrentMonth &&
          currentDate.year == datePickerCurrentYear) {
        color = _currentDayBackgroundColor;
        fontColor = _currentDayFontColor;
      }

      // if current day is belongs to current month and equals to selected date , then change color and font to selected date
      if (day == inputSelectedDate.day &&
          datePickerCurrentMonth == inputSelectedDate.month &&
          datePickerCurrentYear == inputSelectedDate.year) {
        color = _selectedDayBackgroundColor;
        fontColor = _selectedDayFontColor;
      }

      // if current day is belongs to current month and is inside the selected range , then change color and font to selected date
      if ((rangeStartDate != null && rangeFinishDate != null)) {
        if (dayBlockDateTime
                    .toDateTime()
                    .compareTo(rangeStartDate.toDateTime()) >=
                0 &&
            dayBlockDateTime
                    .toDateTime()
                    .compareTo(rangeFinishDate.toDateTime()) <=
                0) {
          color = _selectedDayBackgroundColor;
          fontColor = _selectedDayFontColor;
        }
      }
    }

    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            if (otherMonthDay == false &&
                rangeModeTrueAndDayIsBeforeStart == false) {
              // by tapping on any day, both year and month dialogs should disappear and their animations should reset
              yearAnimationController.reset();
              monthAnimationController.reset();

              if (widget.rangeSelector == true) {
                // if start date is selected, then waiting for finish date selection and clearing input to display new selection
                if (rangeStartDate == null ||
                    (rangeStartDate != null && rangeFinishDate != null)) {
                  rangeStartDate =
                      AfghaniDate(pageInfo['Y'], pageInfo['M'], day);
                  rangeFinishDate = null;
                  widget.controller.text = '';
                } else {
                  rangeFinishDate =
                      AfghaniDate(pageInfo['Y'], pageInfo['M'], day);

                  if (rangeStartDate
                          .toDateTime()
                          .compareTo(rangeFinishDate.toDateTime()) <=
                      0) {
                    widget.controller.text = rangeStartDate.year.toString() +
                        '/' +
                        rangeStartDate.month.toString() +
                        '/' +
                        rangeStartDate.day.toString() +
                        ' - ' +
                        rangeFinishDate.year.toString() +
                        '/' +
                        rangeFinishDate.month.toString() +
                        '/' +
                        rangeFinishDate.day.toString();
                  } else {
                    widget.controller.text = '';
                  }

                  // after selecting both start and finish,
                  // we update `TextField` text and then
                  // we set both start and finish to null so user can select another range
                  rangeStartDate = null;
                  rangeFinishDate = null;
                }
              } else {
                widget.controller.text = pageInfo['Y'].toString() +
                    '/' +
                    pageInfo['M'].toString() +
                    '/' +
                    day.toString();
              }

              // after updating input by selected date, we convert the selected date to afghani date
              inputStringToAfghani();

              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: color,
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(color: fontColor, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePickerPageHeader(pageInfo) {
    DateData datetime = DateData(pageInfo['Y'], pageInfo['M'], 1);
    return Container(
      color: _headerBackgroundColor,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      yearAnimationController.reset();
                      if (monthAnimationController.isDismissed)
                        monthAnimationController.forward();
                      else
                        monthAnimationController.reverse();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.expand_more,
                              size: 18,
                              color: _headerFontColor,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            child: Text(
                              translate('MMM', datetime, false, widget.locale),
                              style: TextStyle(
                                  fontSize: 19, color: _headerFontColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        monthAnimationController.reset();
                        if (yearAnimationController.isDismissed)
                          yearAnimationController.forward();
                        else
                          yearAnimationController.reverse();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(datetime.year.toString(),
                                  style: TextStyle(
                                      fontSize: 19, color: _headerFontColor)),
                            ),
                            SizedBox(width: 8),
                            Container(
                              margin: EdgeInsets.only(top: 1),
                              child: Icon(
                                Icons.expand_more,
                                size: 18,
                                color: _headerFontColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Material(
              child: InkWell(
                onTap: () {
                  datePickerController.animateToPage(todayPageIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _headerTodayIcon,
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            _headerTodayCaption,
                            style: TextStyle(fontSize: 19),
                          ))
                    ],
                  ),
                  color: _headerTodayBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePickerPageWeekCaptions() {
    return Row(
      children: <Widget>[
        _weekDayCaption('ش'),
        _weekDayCaption('ی'),
        _weekDayCaption('د'),
        _weekDayCaption('س'),
        _weekDayCaption('چ'),
        _weekDayCaption('پ'),
        _weekDayCaption('ج'),
      ],
    );
  }

  Widget _weekDayCaption(String title) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6),
        color: _weekCaptionsBackgroundColor,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: _weekCaptionsFontColor, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget displayYears() {
    double itemHeight = 50;

    int selectedYearIndex = years.indexOf(inputSelectedDate.year);
    displayYearsController = ScrollController(
        initialScrollOffset: (selectedYearIndex * itemHeight).toDouble());

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayYearsController,
        itemCount: years.length,
        itemBuilder: (BuildContext context, int index) {
          Color bgColor = _yearSelectionBackgroundColor;
          Color fontColor = _yearSelectionFontColor;
          if (years[index] == datePickerCurrentYear) {
            bgColor = _yearSelectionHighlightBackgroundColor;
            fontColor = _yearSelectionHighlightFontColor;
          }

          return GestureDetector(
            onTap: () {
              inputSelectedDate.year = years[index];
              setState(() {});
              datePickerController.animateToPage(
                  (inputSelectedDate.year - startDate.year) * 12 +
                      datePickerCurrentMonth -
                      1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeOut);
              yearAnimationController.reset();
            },
            child: Container(
              height: itemHeight,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                  color: bgColor),
              child: Center(
                child: Text(
                  years[index].toString(),
                  style: TextStyle(fontSize: 16, color: fontColor),
                ),
              ),
            ),
          );
        });
  }

  Widget displayMonths() {
    double itemHeight = 50;

    displayMonthsController = ScrollController(
        initialScrollOffset: (inputSelectedDate.month * itemHeight).toDouble());

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayMonthsController,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          DateData datetime = DateData(inputSelectedDate.year, index + 1, 1);

          Color bgColor = _monthSelectionBackgroundColor;
          Color fontColor = _monthSelectionFontColor;
          if (index + 1 == datePickerCurrentMonth) {
            bgColor = _monthSelectionHighlightBackgroundColor;
            fontColor = _monthSelectionHighlightFontColor;
          }

          return GestureDetector(
            onTap: () {
              datePickerCurrentMonth = index + 1;
              datePickerController.animateToPage(
                  (datePickerCurrentYear - startDate.year) * 12 + index,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeOut);
              monthAnimationController.reset();
            },
            child: Container(
              height: itemHeight,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                  color: bgColor),
              child: Center(
                  child: Text(
                translate('MMM', datetime, false, widget.locale),
                style: TextStyle(fontSize: 16, color: fontColor),
              )),
            ),
          );
        });
  }
}

