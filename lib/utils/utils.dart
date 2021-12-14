import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static String getTimeAgo(DateTime dateTime) {
    var differenceDateTime = DateTime.now().difference(dateTime);
    final subtractedDateTime = DateTime.now()
        .subtract(Duration(milliseconds: differenceDateTime.inMilliseconds));
    // print(timeago.format(subtractedDateTime, locale: 'en_short'));
    return timeago
        .format(subtractedDateTime, locale: 'en_short')
        .toString()
        .replaceAll(RegExp(r'~'), "");
  }
}
