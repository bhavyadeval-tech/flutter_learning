import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final List<Map<String, String>> countries = [
    {'name': 'London', 'flag': '🇬🇧', 'timezone': 'Europe/London'},
    {'name': 'India', 'flag': '🇮🇳', 'timezone': 'Asia/Kolkata'},
    {'name': 'USA', 'flag': '🇺🇸', 'timezone': 'America/New_York'},
    {'name': 'Japan', 'flag': '🇯🇵', 'timezone': 'Asia/Tokyo'},
    {'name': 'Australia', 'flag': '🇦🇺', 'timezone': 'Australia/Sydney'},
    {'name': 'Canada', 'flag': '🇨🇦', 'timezone': 'America/Toronto'},
    {'name': 'China', 'flag': '🇨🇳', 'timezone': 'Asia/Shanghai'},
    {'name': 'Singapore', 'flag': '🇸🇬', 'timezone': 'Asia/Singapore'},
    {'name': 'Dubai', 'flag': '🇦🇪', 'timezone': 'Asia/Dubai'},
    {'name': 'Germany', 'flag': '🇩🇪', 'timezone': 'Europe/Berlin'},
  ];

  String searchText = '';



  //@override
 // void initState() {
   // super.initState();
   // print('initstate function ran');
 // }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = countries.where(
        (country) => country['name']!.toLowerCase().contains(searchText.toLowerCase()),
    ).toList();
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          //select country from the list of countries
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),

            ),
            child: const Row(
              children: [
                Text(
            'Select Country',
                    style: TextStyle (
                fontSize:16,
              color: Colors.grey,
            ),
                ),
          Spacer(),
          Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          //search box
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchText = value;
                });
            },
    decoration: InputDecoration(
    hintText: 'Search for your country',
    prefixIcon: const Icon(Icons.search),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    ),
    ),
    const SizedBox(height: 10),
    //country list
Expanded(
child: ListView.builder(
itemCount: filteredCountries.length,
itemBuilder: (context, index) {
final country = filteredCountries[index];

return ListTile(
leading: Text(
country['flag']!,
style: const TextStyle(fontSize: 28),
),
title: Text(
country['name']!,
style: const TextStyle(fontSize: 16),
),
onTap: () {
Navigator.pop(
context,
    {
      'name': country['name'],
      'timezone': country['timezone'],
    },
);
},
);
},
),
),
        ],
      ),
    );
  }
}


