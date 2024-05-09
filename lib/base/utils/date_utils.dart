import 'package:easy_localization/easy_localization.dart';

extension DateHelperUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String humanReadableDateString(
      {String format = 'MMM dd, yyyy', shortHand = true}) {
    if (shortHand) {
      if (isToday) {
        return 'Today';
      }
      if (isYesterday) {
        return 'Yesterday';
      }
    }

    return DateFormat(format).format(this);
  }

  bool isSameDay(DateTime previousDate) {
    return day == previousDate.day &&
        month == previousDate.month &&
        year == previousDate.year;
  }

  static String formatDurationInHhMmSs(String durationString) {
    final duration = parseDuration(durationString);
    final hh = duration.inHours.toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');
    if (duration.inHours == 0) {
      return '${mm}m ${ss}s';
    }
    return '${hh}h ${mm}m';
  }

  static String formatDurationInTime(Duration duration) {
    final hh = duration.inHours.toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');
    if (duration.inHours == 0) {
      return '$mm:$ss';
    }
    return '$hh:$mm:$ss';
  }

  static Duration parseDuration(String s) {
    if (s.isEmpty) {
      return Duration.zero;
    }
    var hours = 0;
    var minutes = 0;
    int micros;
    final parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String formatDurationInHourAndMinutes(Duration duration) {
    final hh = duration.inHours.toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');
    if (duration.inHours == 0) {
      if (duration.inMinutes == 0) {
        return '$ss seconds';
      }
      return '$mm minutes';
    }
    return '$hh hours';
  }
}
