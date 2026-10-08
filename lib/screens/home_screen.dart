import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/country.dart';
import '../services/time_service.dart';
import 'choose_country_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? clockTimer;

  // Countries that the user has added.
  final List<Country> selectedCountries = [];

  @override
  void initState() {
    super.initState();

    clockTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Future<void> openChooseCountry() async {
    final Country? selectedCountry =
    await Navigator.push<Country>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const ChooseCountryScreen(),
      ),
    );

    if (selectedCountry == null) {
      return;
    }

    // Don't add the same country twice.
    final alreadyAdded = selectedCountries.any(
          (country) =>
      country.name == selectedCountry.name,
    );

    if (!alreadyAdded) {
      setState(() {
        selectedCountries.add(selectedCountry);
      });
    }
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF1FAF7),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            10,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              // -----------------------------
              // HEADER
              // -----------------------------

              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          'World Clock',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'Select a country to see the current time',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                            Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Text(
                    '🌍',
                    style: TextStyle(
                      fontSize: 58,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // -----------------------------
              // SEARCH
              // -----------------------------

              GestureDetector(
                onTap: openChooseCountry,

                child: Container(
                  height: 55,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(28),
                  ),

                  child: Row(
                    children: [

                      const SizedBox(width: 18),

                      Icon(
                        Icons.search,
                        color:
                        Colors.grey.shade500,
                        size: 27,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        'Search country',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                          Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // -----------------------------
              // ADDED CLOCKS
              // -----------------------------

              Expanded(
                child: selectedCountries.isEmpty
                    ? _emptyState()
                    : GridView.builder(
                  itemCount:
                  selectedCountries.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.88,
                  ),

                  itemBuilder:
                      (context, index) {
                    return _clockCard(
                      selectedCountries[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // EMPTY HOME
  // -----------------------------

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [

          const Text(
            '🌍',
            style: TextStyle(
              fontSize: 55,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'No clocks added yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            selectedCountries.isEmpty
            ? 'Select a country to see the current time'
            : 'Your world clocls',
            style: TextStyle(
              fontSize: 14,
              color:
              Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // CLOCK CARD
  // -----------------------------

  Widget _clockCard(Country country) {
    final now = TimeService.getCurrentTime(country.timezone);

    final time = DateFormat('hh:mm a').format(now);
    final date = DateFormat('EEE, dd MMM').format(now);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4FF),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// Flag + location
            Row(
              children: [
                Text(
                  country.flag,
                  style: const TextStyle(fontSize: 32),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        country.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              ],
            ),

            const Spacer(),

// Time
            Text(
              time,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),

            const SizedBox(height: 5),

// Date
            Text(
              date,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}