import 'dart:convert';

import 'package:http/http.dart' as http;

class TimeService {
  Future<DateTime> getCurrentTime(String timeZone) async {
    final url = Uri.parse(
      'https://timeapi.io/api/Time/current/zone?timeZone=$timeZone',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return DateTime.parse(data['dateTime']);
    } else {
      throw Exception(
        'Failed to get current time',
      );
    }
  }
}