import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  Future<GetAllCategoriesModel> getAllCategories({String? token}) async {
    try {
      final response = await http.get(
        ApiUrls.getAllCat,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      // print(token);
      final result = GetAllCategoriesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 429) {
        throw Exception('user has sent too many requests in a given amount of time ("rate limiting")');
      }
      if (response.statusCode == 200) {
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SearchModel> searchDeal(String token, String search,
      // String country, String city,
      {String? startingDiscount,
      String? endingDiscount,
      String? priceOrder}) async {
    try {
      // debugPrint(
      //     'city and country : $country, $city, $endingDiscount, $startingDiscount, $priceOrder');
      final response = await http.get(
        Uri.parse(
            //getNearByDeals?returnType=customPagination&priceSort=&searchText=$search?cities[0]=$city&cities[1]=$city, country=$country&startingDiscount=$startingDiscount&endingDiscount=$endingDiscount
            '${ApiUrls.baseUrl}user/getDeals?returnType=customPagination&timeSort=asc&searchText=$search'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      log(response.body);
      final result = SearchModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint(result.responseCode.toString());
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
