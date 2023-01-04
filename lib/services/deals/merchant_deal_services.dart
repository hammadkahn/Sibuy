import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/models/merchant_single_deal.dart';
import 'package:http/http.dart' as http;

class DealServices {
  Future<MerchantDealListModel> getAllDeals({required String token}) async {
    print(token);
    final response = await http.get(
      ApiUrls.allDeals,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final result = MerchantDealListModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> createDeal(Map<String, dynamic> data, String token) async {
    try {
      var headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'content-type': 'application/json'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiUrls.baseUrl}merchant/createDeal'))
        ..headers.addAll(headers)
        ..fields.addAll({
          'name': data['name'],
          'discount': data['discount'],
          'product_name': data['product_name'],
          'product_price': data['product_price'],
          'expiry': data['expiry'],
          'redeem_expiry': data['redeem_expiry'],
          'tags[0]': data['tags[0]'],
          'tags[1]': data['tags[1]'],
          'tags[2]': data['tags[2]'],
          'category': data['category'],
          'limit': data['limit'],
          'is_sponsored': data['is_sponsered'],
          'language': data['language'],
        })
        ..files.add(
            await http.MultipartFile.fromPath('images[0]', data['images[0]']))
        ..files.add(
            await http.MultipartFile.fromPath('videos[0]', data['videos[0]']));

      http.StreamedResponse response = await request.send();
      print(response.headers);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return response.statusCode.toString();
      } else {
        print(response.reasonPhrase);
        print(response.statusCode);

        return await response.stream.bytesToString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SingleDealModel> getSingleDeal({
    required String dealId,
    required String token,
  }) async {
    try {
      final url = '${ApiUrls.baseUrl}merchant/getDeal/$dealId';
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      final result = SingleDealModel.fromJson(jsonDecode(response.body));

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

  Future<String> redeemWithCode(String token, String uniqueCode) async {
    log('$token, $uniqueCode');
    try {
      final url =
          Uri.parse('${ApiUrls.baseUrl}merchant/redeemDealByUniqueCode');
      final response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {'uniqueCode': uniqueCode});
      log(response.statusCode.toString());
      if (response.statusCode >= 400 && response.statusCode < 500) {
        return 'This unique code does not exists';
      }
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

  //withdraw services
  Future<Map<String, dynamic>> getWithdrawDetails(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}merchant/getWithdrawAmountStatus'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        debugPrint(response.statusCode.toString());
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> withdrawPayment(String token, String description) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiUrls.baseUrl}merchant/withdrawRequest'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {'description': description});
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return response.statusCode.toString();
      } else {
        debugPrint(response.statusCode.toString());
        return response.reasonPhrase!;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
