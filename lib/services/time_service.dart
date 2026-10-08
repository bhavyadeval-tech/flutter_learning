import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class TimeService {
  static void initialize() {
    tz_data.initializeTimeZones();
  }

  static tz.TZDateTime getCurrentTime(String timezone) {
    final location = tz.getLocation(timezone);

    return tz.TZDateTime.now(location);
  }
}