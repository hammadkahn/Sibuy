import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/deals/user_deals_services.dart';

class filter_list extends StatefulWidget {
  const filter_list({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<filter_list> createState() => _filter_listState();
}

class _filter_listState extends State<filter_list> {
  final List<String> items = ['asc', 'desc'];
  String? selectedValue;
  Country? selectedCountry;
  String? currentCountry = 'Loading...';
  String? currentCity;
  List<dynamic>? systemCitiesDropdown;

  Future<void> getCountryAndCity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // currentCity = pref.getString('city');
      currentCountry = pref.getString('country');
      // address = pref.getString('address');
    });
  }

  Future<void> fetchCitiesAndCountries() async {
    final result = await UserDealServices()
        .getSystemCities(widget.token, currentCountry ?? '');
    debugPrint('country : $currentCountry');
    setState(() {
      systemCitiesDropdown = result['data'];
    });
  }

  RangeValues valuess = const RangeValues(0, 100);
  bool countryFetched = false;

  @override
  void didChangeDependencies() {
    getCountryAndCity()
        .whenComplete(() => fetchCitiesAndCountries().whenComplete(() {
              setState(() {
                countryFetched = true;
              });
            }));

    selectedCountry = const Country(
      name: "Azerbaijan",
      flag: "🇦🇿",
      code: "AZ",
      dialCode: "994",
      minLength: 9,
      maxLength: 9,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Color(0xFFC0C0CF),
              thickness: 5,
              indent: 120,
              endIndent: 120,
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                'Filters',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mulish'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Price Order',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mulish')),
            const SizedBox(
              height: 12,
            ),
            DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'asc',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                  // dealProvider!.setDiscount(value);
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFFff6600),
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 200,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFFff6600),
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
              underline: const SizedBox(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: CountryPickerDialog(
                            searchText: 'Search Country',
                            countryList: countries,
                            onCountryChanged: (value) {
                              setState(() {
                                selectedCountry = value;
                                currentCountry = value.name;
                              });
                              fetchCitiesAndCountries().whenComplete(() {
                                if (systemCitiesDropdown == null ||
                                    systemCitiesDropdown!.isEmpty) {
                                  setState(() {
                                    countryFetched = false;
                                  });
                                } else {
                                  setState(() {
                                    countryFetched = true;
                                  });
                                }
                              });
                              debugPrint('selected: $currentCountry');
                            },
                            selectedCountry: selectedCountry!,
                            filteredCountries: countries),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      primary: const Color(0xFFff6600),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(currentCountry ?? 'Loading...')),
                  ),
                ),
                const SizedBox(width: 5),
                currentCountry != null && countryFetched == true
                    ? Expanded(
                        flex: 2,
                        child: systemCitiesDropdown == null
                            ? const Text('no city found')
                            : DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        systemCitiesDropdown![0],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                items: systemCitiesDropdown!
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: currentCity,
                                onChanged: (value) {
                                  setState(() {
                                    currentCity = value as String;
                                    // dealProvider!.setDiscount(value);
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonWidth: 160,
                                buttonPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xFFff6600),
                                ),
                                buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 200,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xFFff6600),
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                                underline: const SizedBox(),
                              ),
                      )
                    : const Text('Loading...'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Discount Range',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mulish')),
            const SizedBox(
              height: 30,
            ),
            RangeSlider(
              activeColor: Color(0xffff6600),
              inactiveColor: Color(0xFFff6600),
              values: valuess,
              onChanged: (newRange) {
                setState(() => valuess = newRange);
              },
              min: 0,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                valuess.start.round().toString(),
                valuess.end.round().toString(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                text: 'Submit',
                onPressed: () {
                  Provider.of<DealProvider>(context, listen: false).setFitlers([
                    '${valuess.end}',
                    valuess.start.toString(),
                    selectedValue ?? 'asc',
                    currentCountry ?? '',
                    currentCity ?? systemCitiesDropdown![0]
                  ]);
                  Navigator.of(context).pop();
                }),
            const SizedBox(
              height: 20,
            ),
          ]),
    );
  }
}
