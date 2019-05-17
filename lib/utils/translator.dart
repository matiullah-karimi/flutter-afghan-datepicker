import 'package:afghan_datepicker/utils/shared.dart';

/// Translates input format to a readable string date
String translate(String input, DateData date, bool persianNumbers, String locale) {
  input = input.replaceAll("YYYY", date.year.toString());
  input = input.replaceAll("YY", date.year.toString().substring(2, 4));
  input = input.replaceAll("MMM", _getLocalizedMonthName(date.month, locale));
  input = input.replaceAll("MM", date.month.toString().padLeft(2, "0"));
  input = input.replaceAll("M", date.month.toString());
  input = input.replaceAll("DDD", _getLocalizedNumber(date.day, locale));
  input = input.replaceAll("DD", date.day.toString().padLeft(2, "0"));
  input = input.replaceAll("D", date.day.toString());
  if (persianNumbers) {
    input = translateNumbers(input);
  }
  return input;
}

String translateNumbers(String input) {
  input = input.replaceAll("0", "۰");
  input = input.replaceAll("1", "۱");
  input = input.replaceAll("2", "۲");
  input = input.replaceAll("3", "۳");
  input = input.replaceAll("4", "۴");
  input = input.replaceAll("5", "۵");
  input = input.replaceAll("6", "۶");
  input = input.replaceAll("7", "۷");
  input = input.replaceAll("8", "۸");
  input = input.replaceAll("9", "۹");
  return input;
}

/// Returns localized month name
String _getLocalizedMonthName(int month, String locale) {
  switch (month) {
    case 1:
      return locale == "ps" ? "وری" : "حمل";
    case 2:
      return locale == "ps" ? "غویی" : "ثور";
    case 3:
      return locale == "ps" ? "غبرګلی" : "جوزا";
    case 4:
      return locale == "ps" ? "چنګاښ" : "سرطان";
    case 5:
      return locale == "ps" ? "زمری" : "اسد";
    case 6:
      return locale == "ps" ? "وږی" : "سنبله";
    case 7:
      return locale == "ps" ? "تله" : "میزان";
    case 8:
      return locale == "ps" ? "لړم" : "عقرب";
    case 9:
      return locale == "ps" ? "ليندۍ" : "قوس";
    case 10:
      return locale == "ps" ? "مرغومی" : "جدی";
    case 11:
      return locale == "ps" ? "سلواغه" : "دلو";
    case 12:
      return locale == "ps" ? "کب" : "حوت";
    default:
      return "خطا";
  }
}

String _getLocalizedNumber(int number, String locale) {
  String output;
  switch (number) {
    case 1:
      output = locale == "ps" ? "یو" : "یک";
      break;
    case 2:
      output = locale == "ps" ? "دوه" : "دو";
      break;
    case 3:
      output = locale == "ps" ? "دری" : "سه";
      break;
    case 4:
      output = locale == "ps" ? "څلور" : "چهار";
      break;
    case 5:
      output = locale == "ps" ? "پنځه" : "پنج";
      break;
    case 6:
      output = locale == "ps" ? "شپږ" : "شش";
      break;
    case 7:
      output = locale == "ps" ? "اووه" : "هفت";
      break;
    case 8:
      output = locale == "ps" ? "اته" : "هشت";
      break;
    case 9:
      output = locale == "ps" ? "نه" : "نه";
      break;
    case 10:
      output = locale == "ps" ? "لس" : "ده";
      break;
    case 11:
      output = locale == "ps" ? "یولس" : "یازده";
      break;
    case 12:
      output = locale == "ps" ? "دو ولس" : "دوازده";
      break;
    case 13:
      output = locale == "ps" ? "دیار لس" : "سیزده";
      break;
    case 14:
      output = locale == "ps" ? "څوار لس" : "چهارده";
      break;
    case 15:
      output = locale == "ps" ? "پنځه لس" : "پانزده";
      break;
    case 16:
      output = locale == "ps" ? "شپاړس" : "شانزده";
      break;
    case 17:
      output = locale == "ps" ? "اوولس" : "هفده";
      break;
    case 18:
      output = locale == "ps" ? "اته لس" : "هجده";
      break;
    case 19:
      output = locale == "ps" ? "نولس" : "نونزده";
      break;
    case 20:
      output = locale == "ps" ? "شل" : "بیست";
      break;
    case 21:
      output = locale == "ps" ? "یوویشت" : "بیست و یک";
      break;
    case 22:
      output = locale == "ps" ? "دوه ویشت" : "بیست و دو";
      break;
    case 23:
      output = locale == "ps" ? "درویشت" : "بیست و سه";
      break;
    case 24:
      output = locale == "ps" ? "څلور ویشت" : "بیست و چهار";
      break;
    case 25:
      output = locale == "ps" ? "پنځه ویشت" : "بیست و پنج";
      break;
    case 26:
      output = locale == "ps" ? "شپږ ویشت" : "بیست و شش";
      break;
    case 27:
      output = locale == "ps" ? "اووه ویشت" : "بیست و هفت";
      break;
    case 28:
      output = locale == "ps" ? "اته ویشت" : "بیست و هشت";
      break;
    case 29:
      output = locale == "ps" ? "نه ویشت" : "بیست و نه";
      break;
    case 30: 
      output = locale == "ps" ? "دیرش" : "سی";
      break;
    case 31:
      output = locale == "ps" ? "یو دیرش" : "سی و یک";
      break;
    case 32:
      output = locale == "ps" ? "دوه دیرش" : "سی و دو";
      break;
    default:
      return "خطا";
  }
  return output + "م";
}
