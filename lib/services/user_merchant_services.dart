import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/models/top_mecrchant_model.dart';
import 'package:http/http.dart' as http;

import '../apis/api_urls.dart';
import '../models/merchant_model.dart';

class UserMerchantServices {
  Future<MerchantList> merchantListForUsers(String token) async {
    try {
      final response = await http.get(
        ApiUrls.merchantList,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      final result = MerchantList.fromJson(jsonDecode(response.body));
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

  Future<SingleMerchant> singleMerchantProfile(
      {required String id, required String token}) async {
    print('objec : user id : $id');
    try {
      final response = await http
          .get(Uri.parse('${ApiUrls.baseUrl}user/getMerchant/$id'), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      final result = SingleMerchant.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint('name : ${result.data!.id}');
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TopMerchantModel> getTopMerchant(
      String token, String country, String city) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiUrls.baseUrl}user/getTopMerchants?country=$country&city=$city'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      final result = TopMerchantModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 429) {
        debugPrint(
            'user has sent too many requests in a given amount of time ("rate limiting")');
        throw Exception(
            'user has sent too many requests in a given amount of time ("rate limiting")');
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
}
