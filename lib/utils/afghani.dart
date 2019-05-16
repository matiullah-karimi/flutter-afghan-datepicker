import 'package:afghan_date_picker/utils/gregorian.dart';
import 'package:afghan_date_picker/utils/shamsi.dart';
import 'package:afghan_date_picker/utils/shared.dart';
import 'package:afghan_date_picker/utils/translator.dart';

class AfghaniDate {
  /// The day of the month [1..31]
  int day;

  /// The afghani month [1..12]
  int month;

  /// The afghani year
  int year;

  /// Temp instance of [DateTime] used for inital convertion value
  DateTime _dateTime;

  /// Default constructor from Jalali date
  AfghaniDate(int year, int month, int day)
      : year = year,
        month = month,
        day = day;

  /// Constructs a [AfghaniDate] instance with current date
  AfghaniDate.now() {
    _dateTime = new DateTime.now();
    _convertToShamsi(_dateTime.year, _dateTime.month, _dateTime.day);
  }

  /// Constructs a [AfghaniDate] instance from a datetime
  AfghaniDate.fromDateTime(DateTime datetime) : _dateTime = datetime {
    _convertToShamsi(_dateTime.year, _dateTime.month, _dateTime.day);
  }

  /// Constructs a [AfghaniDate] instance from parsing a date string
  AfghaniDate.parse(String stringDate) {
    _dateTime = DateTime.parse(stringDate);
    _convertToShamsi(_dateTime.year, _dateTime.month, _dateTime.day);
  }

  /// Returns a human-readable string for this instance.
  String toString({
    bool showDate = true,
    bool showTime = false,
  }) {
    DateTime.now().toString();
    if (!(showDate || showTime)) {
      throw new Exception(
          'At least one of arguments [showDate or showTime] must be true');
    }
    String stringDate = '';
    if (showDate) {
      stringDate =
          year.toString() + '/' + month.toString() + '/' + day.toString();
    }
    if (showTime) {
      stringDate += ' ' +
          _dateTime.hour.toString() +
          ':' +
          _dateTime.minute.toString() +
          ':' +
          _dateTime.second.toString();
    }
    return stringDate;
  }

  /// Returns a gregorian [DateData] from current shamsi date
  DateData _toGregorian() {
    int jdn = shamsiToJdn(year, month, day);
    DateData gregorin = jdnToGregorian(jdn);
    return gregorin;
  }

  /// Returns an instance of [DateTime] from this [AfghaniDate]
  DateTime toDateTime() {
    DateData date = _toGregorian();
    return new DateTime(date.year, date.month, date.day);
  }

  /// Converts gregorian date to afghani date and stores to this instance of [AfghaniDate]
  void _convertToShamsi(int gyear, int gmonth, int gday) {
    int jdn = gregorianToJdn(gyear, gmonth, gday);
    DateData shamsi = jdnToShamsi(jdn);
    year = shamsi.year;
    month = shamsi.month;
    day = shamsi.day;
  }

  // Returns the afghani date in determined format
  String format(String format, {bool persianNumbers = false, String locale = "fa"}) {
    DateData jDate = DateData(year, month, day);
    return translate(format, jDate, persianNumbers, locale);
  }
}
