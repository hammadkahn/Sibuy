import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/merchant_profile_model.dart';
import 'package:gigi_app/models/user_model.dart';
import 'package:http/http.dart' as http;

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

  Future<UserProfileModel> updateUserProfile(
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(ApiUrls.updateUserProfile,
          body: data,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final userProfile = UserProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint(userProfile.message);
        return userProfile;
      } else {
        debugPrint(userProfile.message);
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

  Future<void> updatePassword(
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(ApiUrls.updateUserProfile,
          body: data,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
