import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = '';
  Future<String> getTime() async {
    Response response = await get(
        Uri.parse(
            'https://timeapi.io/api/Time/current/zone?timeZone=Europe/London'));
    Map data = jsonDecode(response.body);
    //print(data);
    //time = data['time'];
    //String timeZone = data['timeZone'];
    String datetime = data['dateTime'];

    DateTime now = DateTime.parse(datetime);
    time = '${now.hour}:${now.minute.toString().padLeft(2,'0')}';
    return time;


   // print(time);
  }
  //  print(timeZone);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime().then((value) {
      setState(() {
        time = value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          time,
          style: TextStyle(fontSize:40),
        ),
      )
    );
  }
}
