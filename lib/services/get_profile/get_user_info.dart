import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/models/merchant_profile_model.dart';
import 'package:SiBuy/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../models/user_carousel_model.dart';

class UserInformation {
  Future<ProfileModel> getMerchantInformation(String token) async {
    try {
      final response = await http.get(ApiUrls.getMerchantProfile, headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      final result = ProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint(result.data!.name);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserProfileModel> getUserProfile(String token) async {
    try {
      final response = await http.get(ApiUrls.getUserProf, headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      final result = UserProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint(result.data!.name);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCarouselData> getCarouselData() async {
    try {
      final response = await http.get(
        ApiUrls.getCarousel,
      );
      final result = UserCarouselData.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(ApiUrls.updateUserProfile, body: {
        'name': data['name'],
        'phone_no': data['phone_no'],
        'date_of_birth': data['date_of_birth'],
        'gender': data['gender'],
        'languages': data['languages'],
        'locations': data['locations'],
      }, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });
      print(data);
      final userProfile = (jsonDecode(response.body)) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        log(response.body);
        return userProfile;
      } else {
        debugPrint(userProfile['message']);
        return userProfile;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updatePreferences(
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(ApiUrls.updatePreferences,
          body: data,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getUserLocation() async {}
}
