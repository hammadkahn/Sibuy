import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/deal_model.dart';
import 'package:gigi_app/models/merchant_single_deal.dart';
import 'package:http/http.dart' as http;

class DealServices {
  Future<MerchantListOfDeals> getAllDeals({required String token}) async {
    final response = await http.get(
      ApiUrls.allDeals,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final result = MerchantListOfDeals.fromJson(jsonDecode(response.body));
      return result;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      throw Exception(response.reasonPhrase);
    }
  }

  Future<MerchantSingleDeal> getSingleDeal({
    required String dealId,
    required String token,
  }) async {
    try {
      final url = '${ApiUrls.baseUrl}merchant/getDeal/$dealId';
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      final result = MerchantSingleDeal.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return result;
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> redeemPurchase(
      String token, String purchaseId, String branchId) async {
    try {
      final url =
          Uri.parse('${ApiUrls.baseUrl}merchant/radeemDeal/$purchaseId');
      final response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {'branch': branchId});

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return result['message'];
      } else {
        debugPrint(response.body);
        return result['error'];
      }
    } catch (e) {
      debugPrint('err: $e');
      throw Exception(e);
    }
  }
}
