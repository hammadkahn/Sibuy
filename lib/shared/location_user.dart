import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/services/deals/user_deals_services.dart';
import 'package:SiBuy/user_app/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/helper.dart';
import '../user_app/user_menu/ham_user.dart';
import '../../constant/color_constant.dart';

class Location_bar_user extends StatefulWidget {
  const Location_bar_user(
      {Key? key, required this.token, this.updateTrendingList})
      : super(key: key);
  final String token;
  final FutureBuilder? updateTrendingList;

  @override
  State<Location_bar_user> createState() => _Location_bar_userState();
}

class _Location_bar_userState extends State<Location_bar_user> {
  String? selectedValue;
  String? country;

  @override
  void initState() {
    super.initState();
    if(widget.token != ''){
      fetchCitiesAndCountries();
      getCity();
    }
    else{
      selectedValue = "15883";
      country = "Phnom Phen";
      setState(() { });
    }

  }

  getCity() async {
    selectedValue = await AppHelper.getPref('city');
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/images/Vector.png'),
            Padding(
              padding: const EdgeInsets.only(left: 10.94),
              child: widget.token == "" ? Text(country!, style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.APP_PRIMARY_COLOR),
                overflow: TextOverflow.ellipsis,
              ) : items == null
                  ? const Text('fetching...')
                  : DropdownButton2(
                icon: const SizedBox(),
                isExpanded: true,
                hint: Text(
                  country == null || country!.isEmpty ? 'Country' : country!,
                  style: const TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.APP_PRIMARY_COLOR),
                  overflow: TextOverflow.ellipsis,
                ),
                items: items!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.cityName,
                  child: Text(
                    item.cityName,
                    style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.APP_PRIMARY_COLOR),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                underline: const SizedBox(),
                buttonHeight: 30,
                buttonWidth: 160,
                buttonPadding: const EdgeInsets.only(left: 14, right: 8),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                buttonElevation: 0,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 160,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
              ),
            ),
          ],
        ),
        Row(
          children: [
            widget.token == "" ? Container() : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ham_user(
                            token: widget.token,
                          )));
                },
                child: Image.asset('assets/images/drawer.png')),
            const SizedBox(width: 13),
            widget.token == "" ? Container() : InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        NotificationScreen(token: widget.token))));
              },
              child: Image.asset(
                'assets/images/notification.png',
                height: 24,
                width: 24,
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    country = prefs.getString('country');
  }

  List<dynamic>? items;

  Future<void> fetchCitiesAndCountries() async {
    final result = await UserDealServices().getSystemCities(widget.token, 'Pakistan');

    setState(() {
      items = result.data;
    });
  }
}
