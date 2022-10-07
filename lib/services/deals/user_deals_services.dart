import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/deal_model.dart';
import '../../models/puchase_model.dart';

class UserDealServices {
  Future<TrendingDealsModel> trendingDeals(
      String token, String city, String country) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiUrls.baseUrl}user/getTrendingDeals?lat&long&country=$country&cities[0]=$city&cities[1]=$city&priceSort=&timeSort='),
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
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserListOfDeals> getAllUserDeals(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('statement: ${prefs.getString('long')}');
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiUrls.baseUrl}user/getDeals?limit=&page=&returnType=customPagination&timeSort=desc&lat=${prefs.getString('lat') ?? ''}&long=${prefs.getString('long') ?? ''}&startingDiscount&endingDiscount'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      final result = UserListOfDeals.fromJson(jsonDecode(response.body));

      if (response.statusCode == 429) {
        throw Exception('429 error');
      }

      if (response.statusCode == 200) {
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        debugPrint(response.body);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SingleDeal> getSingleDealInfo(String id, String token) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}user/getDeal/$id');
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = SingleDeal.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint(result.message);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
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

      if (response.statusCode == 200) {
        debugPrint('single deal : ${result.message}');

        return result;
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getSystemCities(
      String token, String country) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${ApiUrls.baseUrl}getSystemCitiesByCountry?country=$country'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(result['message']);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
