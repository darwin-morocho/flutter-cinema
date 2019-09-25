import 'package:meta/meta.dart' show required;

class Extras {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static Future sleep({@required int milliseconds}) {
    return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
  }

  static monthToText(int month) {
    final months = [
      "ENE",
      "FEB",
      "MAR",
      "ABR",
      "MAY",
      "JUN",
      "JUL",
      "AGO",
      "SEP",
      "OCT",
      "NOV",
      "DIC"
    ];
    return months[month - 1];
  }
}
