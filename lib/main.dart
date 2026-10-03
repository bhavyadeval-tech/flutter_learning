import 'package:flutter/material.dart';
import 'services/time_service.dart';

void main() {
  runApp(const WorldClockApp());
}

// =====================================================
// APP
// =====================================================

class WorldClockApp extends StatelessWidget {
  const WorldClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Clock',
      home: const HomePage(),
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// =====================================================
// HOME PAGE STATE
// =====================================================

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController =
  TextEditingController();

  // =====================================================
  // COUNTRIES
  // =====================================================

  final List<Map<String, String>> countries = [
    {
      'flag': '🇮🇳',
      'country': 'India',
      'city': 'New Delhi',
      'timeZone': 'Asia/Kolkata',
    },
    {
      'flag': '🇺🇸',
      'country': 'United States',
      'city': 'New York',
      'timeZone': 'America/New_York',
    },
    {
      'flag': '🇬🇧',
      'country': 'United Kingdom',
      'city': 'London',
      'timeZone': 'Europe/London',
    },
    {
      'flag': '🇯🇵',
      'country': 'Japan',
      'city': 'Tokyo',
      'timeZone': 'Asia/Tokyo',
    },
    {
      'flag': '🇦🇺',
      'country': 'Australia',
      'city': 'Sydney',
      'timeZone': 'Australia/Sydney',
    },
    {
      'flag': '🇦🇪',
      'country': 'UAE',
      'city': 'Dubai',
      'timeZone': 'Asia/Dubai',
    },
    {
      'flag': '🇸🇬',
      'country': 'Singapore',
      'city': 'Singapore',
      'timeZone': 'Asia/Singapore',
    },
    {
      'flag': '🇨🇦',
      'country': 'Canada',
      'city': 'Toronto',
      'timeZone': 'America/Toronto',
    },
  ];

  // Only selected countries appear as cards.
  final List<Map<String, String>> addedCountries = [];

  // =====================================================
  // COUNTRY STYLE
  // =====================================================

  Map<String, dynamic> getCountryStyle(String country) {
    switch (country) {
      case 'India':
        return {
          'background': const Color(0xFFFFF4E6),
          'period': const Color(0xFFF39C12),
          'image': 'assets/images/india_gate.png',
        };

      case 'Australia':
        return {
          'background': const Color(0xFFF0EBFF),
          'period': const Color(0xFF9B7EDB),
          'image': 'assets/images/aus_dey.png',
        };

      case 'United States':
        return {
          'background': const Color(0xFFEAF4FF),
          'period': const Color(0xFF4285F4),
          'image': 'assets/images/statue_liberty.png',
        };

      case 'United Kingdom':
        return {
          'background': const Color(0xFFFFEAF1),
          'period': const Color(0xFFE0528C),
          'image': 'assets/images/big_ben.png',
        };

      case 'Japan':
        return {
          'background': const Color(0xFFFFF0F0),
          'period': const Color(0xFFE74C3C),
          'image': 'assets/images/tokyo_tower.png',
        };

      case 'UAE':
        return {
          'background': const Color(0xFFEAFBF4),
          'period': const Color(0xFF20A66A),
          'image': 'assets/images/burj_khalifa.png',
        };

      case 'Singapore':
        return {
          'background': const Color(0xFFFFF1E8),
          'period': const Color(0xFFE67E22),
          'image': 'assets/images/merlion.png',
        };

      case 'Canada':
        return {
          'background': const Color(0xFFFFEEEE),
          'period': const Color(0xFFD94B4B),
          'image': 'assets/images/cn_tower.png',
        };

      default:
        return {
          'background': Colors.white,
          'period': Colors.black,
          'image': '',
        };
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final String searchText =
    searchController.text.trim().toLowerCase();

    final List<Map<String, String>> searchResults =
    countries.where((country) {
      return country['country']!
          .toLowerCase()
          .contains(searchText);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE1F2EC),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            const SizedBox(height: 40),

            // =================================================
            // TITLE
            // =================================================

            const Text(
              'World Clock 🌍',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select a country to see the current time',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // SEARCH
            // =================================================

            TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {});
              },

              decoration: InputDecoration(
                hintText: 'Search country',
                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            // =================================================
            // SEARCH RESULTS
            // =================================================

            if (searchText.isNotEmpty) ...[
              const SizedBox(height: 12),

              ListView.separated(
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount: searchResults.length,

                separatorBuilder: (context, index) {
                  return const Divider(height: 1);
                },

                itemBuilder: (context, index) {
                  final country = searchResults[index];

                  return ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),

                    leading: Text(
                      country['flag']!,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),

                    title: Text(
                      country['country']!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: Text(
                      country['city']!,
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                    ),

                    onTap: () async {
                      final result =
                      await Navigator.push<
                          Map<String, String>>(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              CountryDetailsPage(
                                flag: country['flag']!,
                                country: country['country']!,
                                city: country['city']!,
                                timeZone:
                                country['timeZone']!,
                              ),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          final bool alreadyAdded =
                          addedCountries.any(
                                (item) =>
                            item['country'] ==
                                result['country'],
                          );

                          if (!alreadyAdded) {
                            addedCountries.add(result);
                          }

                          searchController.clear();
                        });
                      }
                    },
                  );
                },
              ),
            ],

            // =================================================
            // MY WORLD CLOCK
            // =================================================

            if (addedCountries.isNotEmpty) ...[
              const SizedBox(height: 30),

              const Text(
                'My World Clock',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount: addedCountries.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 180,
                ),

                itemBuilder: (context, index) {
                  final country =
                  addedCountries[index];

                  final style = getCountryStyle(
                    country['country']!,
                  );

                  return CountryCard(
                    flag: country['flag']!,
                    country: country['country']!,
                    city: country['city']!,
                    time: country['time']!,
                    date: country['date']!,

                    backgroundColor:
                    style['background'],

                    periodColor:
                    style['period'],

                    image: style['image'],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

// =====================================================
// COUNTRY DETAILS PAGE
// =====================================================

class CountryDetailsPage extends StatefulWidget {
  final String flag;
  final String country;
  final String city;
  final String timeZone;

  const CountryDetailsPage({
    super.key,
    required this.flag,
    required this.country,
    required this.city,
    required this.timeZone,
  });

  @override
  State<CountryDetailsPage> createState() =>
      _CountryDetailsPageState();
}

class _CountryDetailsPageState
    extends State<CountryDetailsPage> {

  final TimeService timeService = TimeService();

  late Future<DateTime> currentTime;

  @override
  void initState() {
    super.initState();

    currentTime =
        timeService.getCurrentTime(widget.timeZone);
  }

  // =====================================================
  // TIME FORMAT
  // =====================================================

  String formatTime(DateTime time) {
    int hour = time.hour;

    final minute =
    time.minute.toString().padLeft(2, '0');

    final period =
    hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  // =====================================================
  // DATE FORMAT
  // Example: 2nd Oct 2026
  // =====================================================

  String formatDate(DateTime time) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String suffix;

    if (time.day >= 11 && time.day <= 13) {
      suffix = 'th';
    } else {
      switch (time.day % 10) {
        case 1:
          suffix = 'st';
          break;

        case 2:
          suffix = 'nd';
          break;

        case 3:
          suffix = 'rd';
          break;

        default:
          suffix = 'th';
      }
    }

    return '${time.day}$suffix '
        '${months[time.month - 1]} '
        '${time.year}';
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country),
      ),

      body: SafeArea(
        child: FutureBuilder<DateTime>(
          future: currentTime,

          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Unable to get current time',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            }

            final time = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,

                  children: [
                    const SizedBox(height: 30),

                    Text(
                      widget.flag,
                      style: const TextStyle(
                        fontSize: 70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      widget.country,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.city,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      formatTime(time),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      formatDate(time),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 50),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            {
                              'flag': widget.flag,
                              'country':
                              widget.country,
                              'city': widget.city,
                              'timeZone':
                              widget.timeZone,
                              'time':
                              formatTime(time),
                              'date':
                              formatDate(time),
                            },
                          );
                        },

                        child: const Text(
                          'Add to World Clock',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// =====================================================
// COUNTRY CARD
// =====================================================

class CountryCard extends StatelessWidget {
  final String flag;
  final String country;
  final String city;
  final String time;
  final String date;

  final Color backgroundColor;
  final Color periodColor;

  final String image;

  const CountryCard({
    super.key,
    required this.flag,
    required this.country,
    required this.city,
    required this.time,
    required this.date,
    required this.backgroundColor,
    required this.periodColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    // Split time safely.
    final timeParts = time.split(' ');

    final clockTime =
    timeParts.isNotEmpty
        ? timeParts[0]
        : '';

    final period =
    timeParts.length > 1
        ? timeParts[1]
        : '';

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Stack(
        children: [

          // =================================================
          // MAIN CONTENT
          // =================================================

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              // =================================================
              // FLAG + COUNTRY + CITY
              // =================================================

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // CIRCULAR FLAG
                  Container(
                    width: 38,
                    height: 38,

                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),

                    alignment: Alignment.center,

                    child: Text(
                      flag,
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // COUNTRY + CITY

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          country,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          city,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =================================================
              // TIME
              // =================================================

              RichText(
                maxLines: 1,

                text: TextSpan(
                  children: [

                    TextSpan(
                      text: clockTime,

                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const TextSpan(
                      text: ' ',
                    ),

                    TextSpan(
                      text: period,

                      style: TextStyle(
                        fontSize: 25,
                        fontWeight:
                        FontWeight.bold,
                        color: periodColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // =================================================
              // DATE
              // =================================================

              Text(
                date,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),

          // =================================================
          // COUNTRY LANDMARK IMAGE
          // =================================================

          if (image.isNotEmpty)
            Positioned(
              right: -10,
              bottom: -10,

              child: Image.asset(
                  image,

                width: 85,
                height: 75,

                fit: BoxFit.contain,

                errorBuilder:
                    (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 46,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}