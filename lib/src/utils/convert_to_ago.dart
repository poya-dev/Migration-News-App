String convertToAgo(DateTime input, String locale) {
  Duration diff = DateTime.now().difference(input);

  String dayAgo = locale == 'fa' ? 'روز قبل' : 'ورځ وړاندې';
  String hourAgo = locale == 'fa' ? 'ساعت پیش' : 'ساعت مخکې';
  String minuteAgo = locale == 'fa' ? 'دقیقه پیش' : 'دقیقه مخکې';
  String secondAgo = locale == 'fa' ? 'ثانیه پیش' : 'څو ثانیې مخکې';
  String justNow = locale == 'fa' ? 'همین حالا' : 'همدا اوس';

  if (diff.inDays >= 1) {
    return '${diff.inDays} $dayAgo';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} $hourAgo';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} $minuteAgo';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} $secondAgo';
  } else {
    return justNow;
  }
}
