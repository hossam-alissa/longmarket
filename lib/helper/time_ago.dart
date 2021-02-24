import '../config/config.dart';

class TimeAgo{
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return  isLeft ? '${(difference.inDays / 365).floor()} years ago' : '${(difference.inDays / 365).floor()} منذ سنة';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return isLeft ?  (numericDates) ? '1 year ago' : 'Last year' :  (numericDates) ? 'منذ سنة ١' : 'السنة الماضية';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return isLeft ?  '${(difference.inDays / 365).floor()} months ago' : '${(difference.inDays / 365).floor()} منذ شهر';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return isLeft ? (numericDates) ? '1 month ago' : 'Last month' :  (numericDates) ? '1 شهر' : 'منذ شهر';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return isLeft ?  '${(difference.inDays / 7).floor()} W ' :  '${(difference.inDays / 7).floor()} اسبوع ';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return isLeft ?  (numericDates) ? '1 W ' : 'Last week' :  (numericDates) ? '1 أسبوع ' : ' الإسبوع الماضي';
    } else if (difference.inDays >= 2) {
      return isLeft ? '${difference.inDays} D ' : '${difference.inDays} ي ';
    } else if (difference.inDays >= 1) {
      return isLeft ?   (numericDates) ? '1 D' : 'Yesterday' :  (numericDates) ? '١ ي' : 'مبارح';
    } else if (difference.inHours >= 2) {
      return isLeft ?  '${difference.inHours} H ' :  '${difference.inHours} س ';
    } else if (difference.inHours >= 1) {
      return isLeft ?  (numericDates) ? '1 H ' : 'An H' :  (numericDates) ? '1 س ' : 'ساعات';
    } else if (difference.inMinutes >= 2) {
      return  isLeft ? '${difference.inMinutes} M ' : '${difference.inMinutes} د ';
    } else if (difference.inMinutes >= 1) {
      return  isLeft ? (numericDates) ? '1 M' : 'An M' :  (numericDates) ? '1 د' : 'دقائق';
    } else if (difference.inSeconds >= 3) {
      return  isLeft ? '${difference.inSeconds} Sec' : '${difference.inSeconds} ث'  ;
    } else {
      return isLeft ? 'Just now' :"الأن";
    }
  }
}

// static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
// DateTime date = DateTime.parse(dateString);
// final date2 = DateTime.now();
// final difference = date2.difference(date);
//
// if ((difference.inDays / 365).floor() >= 2) {
// return '${(difference.inDays / 365).floor()} years ago';
// } else if ((difference.inDays / 365).floor() >= 1) {
// return (numericDates) ? '1 year ago' : 'Last year';
// } else if ((difference.inDays / 30).floor() >= 2) {
// return '${(difference.inDays / 365).floor()} months ago';
// } else if ((difference.inDays / 30).floor() >= 1) {
// return (numericDates) ? '1 month ago' : 'Last month';
// } else if ((difference.inDays / 7).floor() >= 2) {
// return '${(difference.inDays / 7).floor()} weeks ago';
// } else if ((difference.inDays / 7).floor() >= 1) {
// return (numericDates) ? '1 week ago' : 'Last week';
// } else if (difference.inDays >= 2) {
// return '${difference.inDays} days ago';
// } else if (difference.inDays >= 1) {
// return (numericDates) ? '1 day ago' : 'Yesterday';
// } else if (difference.inHours >= 2) {
// return '${difference.inHours} hours ago';
// } else if (difference.inHours >= 1) {
// return (numericDates) ? '1 hour ago' : 'An hour ago';
// } else if (difference.inMinutes >= 2) {
// return '${difference.inMinutes} minutes ago';
// } else if (difference.inMinutes >= 1) {
// return (numericDates) ? '1 minute ago' : 'A minute ago';
// } else if (difference.inSeconds >= 3) {
// return '${difference.inSeconds} seconds ago';
// } else {
// return 'Just now';
// }
// }