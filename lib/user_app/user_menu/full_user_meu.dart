import 'dart:developer';
import 'package:SiBuy/models/user_model.dart';
import 'package:SiBuy/user_app/user_menu/categ.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/user_app/user_menu/details_with_all.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../constant/helper.dart';
import '../../constant/size_constants.dart';
import '../../shared/loader.dart';
import '../../shared/search_field.dart';
import '../notification_screen.dart';
import 'ham_user.dart';

class Full_menu_user extends StatefulWidget {
  const Full_menu_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Full_menu_user> createState() => _Full_menu_userState();
}

class _Full_menu_userState extends State<Full_menu_user> {
  DealProvider? dealProvider;
  String? selectedValue;
  String? cityCode, city;
  final prefs = SharedPreferences.getInstance();
  ValueNotifier<List<dynamic>>? items = ValueNotifier([]);

  List a = [
    Image.asset('assets/images/bev.png'),
    Image.asset('assets/images/bev.png'),
    Image.asset('assets/images/bev.png'),
  ];

  // Future<void> getCountry() async {
  //   debugPrint('widget : ${widget.token}');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   country = prefs.getString('country');
  // }

  @override
  initState() {
    getCityCode();
    super.initState();
  }

  getCityCode() async {
    cityCode = await AppHelper.getPref('cityId');
    city = await AppHelper.getPref('city');
    print(cityCode);
    print(city);
    setState(() {});
  }

  Future<void> fetchCitiesAndCountries() async {
    await dealProvider!.getSystemCities(widget.token);
    items!.value = dealProvider!.userCities;
  }

  ValueNotifier<bool> productLoaded = ValueNotifier(false);

  @override
  void didChangeDependencies() {
    dealProvider = Provider.of<DealProvider>(context, listen: false);

    super.didChangeDependencies();

    fetchCitiesAndCountries().whenComplete(
      () => dealProvider!.getCarousalsDeals(widget.token).whenComplete(
        () {
          productLoaded.value = true;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                locationDropdown(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'SiBuy365, Discounts for Everyone in Cambodia',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF32324D)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SearchField(
                  token: widget.token,
                ),
                ValueListenableBuilder(
                  valueListenable: productLoaded,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return SizedBox(
                        child: productLoaded.value == false
                            ? Loader()
                            : const SizedBox()
                        // : C_slider(
                        //     token: widget.token,
                        //     merchantList:
                        //         dealProvider!.userListOfDeals['data']!,
                        //   ),
                        );
                  },
                ),
                //two rows with 8 icons of categories
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF32324D)),
                ),
                categ(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Most Purchased Vouchers in ",
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF505050)),
                      ),
                      Text(
                        city ?? '',
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.APP_PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: userTrendingDeals(isForSponsored: true),
                ),
                Insets.gapH10,
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      const Text(
                        "Deals in ",
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF505050)),
                      ),
                      Text(
                        city ?? '',
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.APP_PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: userTrendingDeals(),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  userTrendingDeals({bool? isForSponsored = false}) {
    return FutureBuilder<UserDealListModel>(
      future: dealProvider!.cityWiseDealsList(cityCode: cityCode ?? '64968'),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loader();
          default:
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()),
              );
            } else {
              if (snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                return Center(
                  child: Text(isForSponsored == true
                      ? 'No deals sponsored'
                      : 'No deals in trending'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return all_details(
                      dealId: snapshot.data!.data![index],
                      token: widget.token,
                    );
                    // return isForSponsored == false
                    //     ? all_details(
                    //         dealId: snapshot.data!.data![index],
                    //         token: widget.token,
                    //       )
                    //     : snapshot.data!.data![index].isSponsored == 1
                    //         ? all_details(
                    //             dealId: snapshot.data!.data![index],
                    //             token: widget.token,
                    //           )
                    //         : const SizedBox();
                  }),
                );
              }
            }
        }
      }),
    );
  }

  //location dropdown
  Widget locationDropdown() {
    return Row(
      children: [
        Image.asset('assets/images/Vector.png'),
        ValueListenableBuilder(
          valueListenable: items!,
          builder: (BuildContext context, List<dynamic> value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.94),
              child: items == null
                  ? const Text('fetching...')
                  : DropdownButton2(
                      icon: const SizedBox(),
                      isExpanded: true,
                      hint: Text(
                        city == null || city!.isEmpty ? 'City' : city!,
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.APP_PRIMARY_COLOR),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: items!.value
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.APP_PRIMARY_COLOR),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: city,
                      onChanged: (value) {
                        setState(() {
                          city = value as String?;
                        });
                        cityCode = dealProvider!.userCitiesData.data!
                            .firstWhere((element) => element.cityName == city)
                            .cityId
                            .toString();
                        AppHelper.setPref('cityId', cityCode);
                        AppHelper.setPref('city', city);
                        // for (var i in dealProvider!.userCitiesData.data!) {
                        //   if (i.cityName == city) {
                        //     cityCode = i.cityId.toString();
                        //     log('matched');
                        //   } else {
                        //     log('no match found');
                        //   }
                        // }
                      },
                      underline: const SizedBox(),
                      buttonHeight: 30,
                      buttonWidth: 100,
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
            );
          },
        ),
        const Spacer(),
        GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (_) => ham_user(
                            token: widget.token,
                          )))
                  .then((value) {
                setState(() {});
              });
            },
            child: Image.asset('assets/images/drawer.png')),
        const SizedBox(width: 13),
        InkWell(
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
    );
  }
}
