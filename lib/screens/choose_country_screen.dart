import 'package:flutter/material.dart';
import 'package:world_clock_new/screens/country_detail_screen.dart';

import '../data/countries.dart';
import '../models/country.dart';
import 'country_detail_screen.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({super.key});

  @override
  State<ChooseCountryScreen> createState() =>
      _ChooseCountryScreenState();
}

class _ChooseCountryScreenState
    extends State<ChooseCountryScreen> {
  final TextEditingController searchController =
  TextEditingController();

  List<Country> filteredCountries = countries;

  @override
  void initState() {
    super.initState();

    filteredCountries = [...countries];

    filteredCountries.sort(
          (a, b) => a.name.compareTo(b.name),
    );

    searchController.addListener(
      filterCountries,
    );
  }

  void filterCountries() {
    final searchText =
    searchController.text.toLowerCase();

    setState(() {
      filteredCountries = countries
          .where(
            (country) =>
        country.name
            .toLowerCase()
            .contains(searchText) ||
            country.city
                .toLowerCase()
                .contains(searchText),
      )
          .toList();

      filteredCountries.sort(
            (a, b) => a.name.compareTo(b.name),
      );
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF3FAF7),

      appBar: AppBar(
        backgroundColor:
        Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Choose a Country',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [

          // Search box
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              15,
            ),

            child: Container(
              height: 55,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(28),
              ),

              child: TextField(
                controller:
                searchController,

                decoration:
                const InputDecoration(
                  hintText:
                  'Search country',

                  prefixIcon: Icon(
                    Icons.search,
                  ),

                  border:
                  InputBorder.none,

                  contentPadding:
                  EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),

          // Country list
          Expanded(
            child: ListView.builder(
              itemCount:
              filteredCountries.length,

              itemBuilder:
                  (context, index) {

                final country =
                filteredCountries[index];

                return ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 5,
                  ),

                  leading: Text(
                    country.flag,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),

                  title: Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    country.city,
                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                    ),
                  ),

                  trailing:
                  const Icon(
                    Icons.chevron_right,
                  ),

                  onTap: () async {
                      final Country? addedCountry =
                          await Navigator.push<Country>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CountryDetailScreen(
                                country: country,
                              ),
                        ),
                      );

                      if (addedCountry != null && mounted) {
                        Navigator.pop(
                          context,
                          addedCountry,
                        );
                      }
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