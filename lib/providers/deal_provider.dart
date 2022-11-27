import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:SiBuy/services/categories/category_services.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/models/puchase_model.dart';
import 'package:SiBuy/models/reviews_model.dart';
import 'package:SiBuy/models/wish_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api_urls.dart';
import '../models/category_model.dart';
import '../models/deal_model.dart';
import '../services/user_merchant_services.dart';

class DealProvider with ChangeNotifier {
  TrendingDealsModel? dealsDataList;
  DealDetails? _dealData;
  CartData? _purchaseData;
  // List<CartData>? _uniqueList;

  final List<CartData> _cartData = [];
  List<String> _rating = [];
  List<String>? _filters;
  bool _filterCheck = false;

  List<String>? get filters => _filters!;

  String _msg = 'purchase fail';
  String? merchantAddress = 'Loading...';

  String? get address => merchantAddress;
  TrendingDealsModel get deals => dealsDataList!;
  DealDetails get dealData => _dealData!;
  CartData get purchaseData => _purchaseData!;
  List<String> get ratingFilter => _rating;
  bool get filterCheck => _filterCheck;

  List<CartData> get cartData => _cartData;
  // List<CartData> get uniqueList => _uniqueList!;

  String get msg => _msg;

  void setFitlers(List<String> data) {
    _filters = data;
    debugPrint('$_filters');
    _filterCheck = true;

    debugPrint('$_filterCheck');
    notifyListeners();
  }

  void setRating(List<String> stars) {
    if (stars.length <= 5) {
      _rating = stars;
    }
    notifyListeners();
  }

  Future<void> tryCatch(String token, dynamic url,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await http.post(
        url,
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(response.body);
        _msg = '${result['message']}';
      } else {
        _msg = result['message'];

        throw Exception(response.statusCode);
      }
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchTrendingDeals(String token) async {
    debugPrint('token provider: $token');
    try {
      final response = await http.get(
        ApiUrls.trendingDealsUrl,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = TrendingDealsModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        debugPrint(result.message);

        dealsDataList = result;
        debugPrint(dealsDataList!.data.toString());
        notifyListeners();
      } else {
        debugPrint(response.reasonPhrase);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('error : $e');
      throw Exception(e);
    }
  }

  Future<void> addToCart(String token, Map<String, dynamic> data) async {
    await tryCatch(token, ApiUrls.purchaseDeal, data: data);
  }

  Future<CartListModel> getCartItemsList(String token) async {
    try {
      final response = await http.get(
        ApiUrls.cartList,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = CartListModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        for (var element in result.data!) {
          _cartData.removeWhere((e) => element.name == e.name);
          _cartData.add(element);
        }
        notifyListeners();
        return result;
      } else {
        throw Exception(result.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> wishList(String token, Map<String, dynamic> data) async {
    await tryCatch(token, ApiUrls.addToWishList, data: data);
  }

  Future<WishListModel> getWishList(String token) async {
    try {
      final response = await http.get(
        ApiUrls.getWishList,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = WishListModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception(result.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SingleDeal> singleDealDetails(String token, String id) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}user/getDeal/$id');
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = SingleDeal.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _dealData = result.data;
        print('dealData: $dealData');
        notifyListeners();
        return result;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SinglePurchaseModel> purchaseDetails(String token, String id) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}user/getPurchaseDeal/$id');
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      debugPrint(response.statusCode.toString());
      final result = SinglePurchaseModel.fromJson(jsonDecode(response.body));
      final mapResult = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint('single deal : ${result.message}');

        notifyListeners();
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeFromWishList(String id, String token) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}user/deleteFromWishlist/$id');
      final response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        _msg = 'removed from wish list ${result['message']}fully';
        notifyListeners();
      } else {
        _msg = result['message'];
        debugPrint(response.reasonPhrase);

        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ReviewsModel> getDealRating(String token, String dealId) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}user/getDealsReviews/$dealId');
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = ReviewsModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return result;
      } else {
        _msg = result.message!;
        debugPrint(response.reasonPhrase);

        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMerchantAddress(String merchantId, String token) async {
    final result = await UserMerchantServices().singleMerchantProfile(
      id: merchantId,
      token: token,
    );
    merchantAddress = result.data!.branches![0].address;
    notifyListeners();
  }

  TrendingDealsModel? _userListOfDeals;

  TrendingDealsModel get userListOfDeals => _userListOfDeals!;

  Future<void> getAllUserDeals(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('statement: ${prefs.getString('country')}');
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiUrls.baseUrl}user/getTrendingDeals?country=${prefs.getString('country')}&cities[1]=${prefs.getString('city')}&cities[0]=${prefs.getString('city')}'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      debugPrint('status code : ${response.statusCode}');
      final result = TrendingDealsModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 429) {
        debugPrint(
            'user has sent too many requests in a given amount of time ("rate limiting")');
        throw Exception('error 429');
      }

      if (response.statusCode == 200) {
        debugPrint(result.message);
        _userListOfDeals = result;
        notifyListeners();
      } else {
        debugPrint(response.reasonPhrase);
        debugPrint(response.body);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }

    // try {
    //   final response = await http.get(
    //     Uri.parse(
    //         '${ApiUrls.baseUrl}user/getDeals?limit=&page=&returnType=customPagination&timeSort=desc&lat=${prefs.getString('lat') ?? ''}&long=${prefs.getString('long') ?? ''}'),
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //   );

    //   final result = UserListOfDeals.fromJson(jsonDecode(response.body));

    //   if (response.statusCode == 429) {
    //     throw Exception('429 error');
    //   }

    //   if (response.statusCode == 200) {
    //     _userListOfDeals = result;
    //     notifyListeners();
    //   } else {
    //     debugPrint(response.reasonPhrase);
    //     debugPrint(response.body);
    //     throw Exception(response.statusCode);
    //   }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

//calculate discount
  String calculateDiscount(
    String discountOnPrice,
    dynamic price,
  ) {
    print('price :$discountOnPrice');
    double? priceAfterDiscount = 0;
    double? getPrice;
    double? percentage;
    percentage = double.parse(discountOnPrice) / 100;
    getPrice = percentage * double.parse(price);
    priceAfterDiscount = (double.parse(price) - getPrice);

    print(percentage);
    print(getPrice);
    print(priceAfterDiscount);

    return priceAfterDiscount.toStringAsFixed(2);
  }

//rating stars
  List<Image> getStars(int stars) {
    List<Image> list = List.empty(growable: true);
    switch (stars) {
      case 1:
        {
          List.generate(
            stars,
            (index) => list.add(
              Image.asset('assets/images/rate.png', width: 15, height: 15),
            ),
          );
          return list;
        }
      case 2:
        {
          List.generate(
              stars,
              (index) => list.add(
                    Image.asset('assets/images/rate.png',
                        width: 15, height: 15),
                  ));
          return list;
        }
      case 3:
        {
          List.generate(
            stars,
            (index) => list.add(
              Image.asset('assets/images/rate.png', width: 15, height: 15),
            ),
          );
          return list;
        }
      case 4:
        {
          List.generate(
            stars,
            (index) => list.add(
              Image.asset('assets/images/rate.png', width: 15, height: 15),
            ),
          );
          return list;
        }
      case 5:
        {
          List.generate(
            stars,
            (index) => list.add(
              Image.asset('assets/images/rate.png', width: 15, height: 15),
            ),
          );
          return list;
        }
      default:
        return list;
    }
  }

  List<String>? _languages;
  List<String> get languages => _languages!;

  Map<String, dynamic>? _languageData;
  Map<String, dynamic> get languageData => _languageData!;

  //general apis
  Future<void> getAllLanguages() async {
    List<String> languageList = [];
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}getAllLanguages'),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        log(response.body);
        List.generate(data['data'].length, (i) {
          languageList.add(data['data'][i]['name']);
          log(data['data'][i]['name']);
        });
        _languages = languageList;
        _languageData = data;
        notifyListeners();
      } else {
        log(response.statusCode.toString());
        _languages = [];
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  List<String>? _allCategories;
  List<String> get allCategories => _allCategories!;

  GetAllCategoriesModel? _catData;
  GetAllCategoriesModel get catData => _catData!;

  Future<void> getAllCat() async {
    List<String> catList = [];
    final result = await CategoryServices().getAllCategories();
    if (result.status == true) {
      print(result.data);
      List.generate(result.data!.length,
          (index) => catList.add(result.data![index].name!));

      _allCategories = catList;
      _catData = result;
      notifyListeners();
    } else {
      print(result.message);
    }
  }
}
