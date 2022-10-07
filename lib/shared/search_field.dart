import 'package:flutter/material.dart';
import 'package:gigi_app/models/category_model.dart';
import 'package:gigi_app/providers/deal_provider.dart';
import 'package:gigi_app/services/categories/category_services.dart';
import 'package:gigi_app/shared/search_result.dart';
import 'package:gigi_app/user_app/user_menu/filter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/size_constants.dart';

class SearchField extends StatefulWidget {
  final String token;
  const SearchField({Key? key, required this.token}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController controller = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RangeValues valuess = const RangeValues(0, 100);
  String? country;
  String? city;
  String? address;
  String? priceFilter = 'asc';
  String? startDiscount = '0';
  String? endDiscount = '100';

  Future<void> getCountryAndCity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      city = pref.getString('city');
      country = pref.getString('country');
      address = pref.getString('address');
    });
  }

  @override
  void initState() {
    getCountryAndCity().whenComplete(() => debugPrint(city));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.85,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8E8EA9)),
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => debugPrint(value),
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenWidth(15)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFFC0C0CF)),
              onPressed:
                  Provider.of<DealProvider>(context).filterCheck == false ||
                          city == null ||
                          city!.isEmpty ||
                          country!.isEmpty
                      ? () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Set Filters first')))
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('searching...')));
                          searchData().whenComplete(() {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SearchResult(
                                  searchModel: searchModel!,
                                  token: widget.token,
                                ),
                              ),
                            );
                            controller.clear();
                          });
                        }),
          prefixIcon: GestureDetector(
            onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return filter_list(token: widget.token);
                }),
            child: const Icon(
              Icons.filter_list,
              color: Color(0xFFC0C0CF),
            ),
          ),
          hintText: 'Search Deals',
        ),
      ),
    );
  }

  SearchModel? searchModel;

  Future<void> searchData() async {
    final provider = Provider.of<DealProvider>(context, listen: false);

    final result = await CategoryServices().searchDeal(
      widget.token,
      controller.text,
      provider.filters![3],
      provider.filters![4],
      startingDiscount: provider.filters![1],
      // provider.startingDiscount.toString(),
      priceOrder: provider.filters![2],
      // provider.priceOrder ?? priceFilter,
      endingDiscount: provider.filters![0],
    );
    // provider.endignDiscount.toString());

    if (result.message == 'success') {
      debugPrint(result.message);
      setState(() {
        searchModel = result;
      });
    } else {
      debugPrint(result.message);
      setState(() {
        searchModel = result;
      });
    }
  }
}
