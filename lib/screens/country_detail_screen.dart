import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/country.dart';
import '../services/time_service.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    final currentTime =
    TimeService.getCurrentTime(country.timezone);

    final time =
    DateFormat('hh:mm a').format(currentTime);

    final date =
    DateFormat('EEEE, dd MMMM yyyy')
        .format(currentTime);

    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF7),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'World Clock',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              // Flag
              Text(
                country.flag,
                style: const TextStyle(
                  fontSize: 80,
                ),
              ),

              const SizedBox(height: 20),

              // Country
              Text(
                country.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // City
              Text(
                country.city,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 35),

              // Time
              Text(
                time,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Date
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 45),

              // Add button
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, country);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.black,
                    foregroundColor:
                    Colors.white,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(28),
                    ),
                  ),

                  child: const Text(
                    '+ Add to World Clock',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}