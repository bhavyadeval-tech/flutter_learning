import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String location = 'London';
  String timezone = 'Europe/London';
  String time = '';
  String date = '';
Future<String> getTime(String timezone) async {
Response response = await get(
Uri.parse(
'https://timeapi.io/api/Time/current/zone?timeZone=$timezone',
),
);

Map data = jsonDecode(response.body);

String datetime = data['dateTime'];

DateTime now = DateTime.parse(datetime);
date = '${now.day}/${now.month}/${now.year}';
int hour = now.hour;
String period = hour >= 12 ? 'PM' : 'AM';

hour = hour % 12;

if (hour == 0) {
  hour = 12;
}

return '$hour:${now.minute.toString().padLeft(2, '0')} $period';

//return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
}

@override
void initState() {
super.initState();

getTime(timezone).then((value) {
setState(() {
time = value;
});
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Colors.deepPurple[700],
body: SafeArea(
child: Column(
children: [
  const Spacer(),
//country
Text(
location,
style: const TextStyle(
    fontSize: 30,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 20),
//time
Text(
time,
style: const TextStyle(
    fontSize: 70,
fontWeight: FontWeight.w300,
color: Colors.white,
),
),
  const SizedBox(height: 10),
  Text(
    date,
    style: const TextStyle(
      fontSize: 20,
      color: Colors.white70,
    ),
  ),
  const Text(
    'current local time',
    style: TextStyle(
      fontSize: 18,
      color:  Colors.white70,
    ),
  ),
  const Spacer(),
  //edit location button
  Padding(
    padding: const EdgeInsets.only(bottom: 40),
    child: ElevatedButton.icon(

    onPressed: () {
      Navigator.pushNamed(context, '/location').then((value) {
        if (value != null) {
          final data = value as Map;
          setState(() {
            //timezone = value.toString();
            location = data['name'];
            timezone = data['timezone'];
          });

          getTime(timezone).then((value) {
            setState(() {
              time = value;
            });
          });
        }
      });
    },
    icon: const Icon(Icons.edit_location),
    label: const Text(
        'Change Location',
      style: TextStyle(fontSize: 16),
    ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
      ),
    ),
  ),
],
),
),
);
}
}



