import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MerchantAuthServices {
  Future<Map<String, dynamic>> merchantRegisteration(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(
        ApiUrls.merchantSignUp,
        body: data,
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return result;
      } else {
        print(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      print('object: $e');
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> userSignUp(
      {required Map<String, dynamic> data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        ApiUrls.userSignUp,
        body: data,
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        prefs.setString('country', result['data']['location']['country']);
        return result;
      } else {
        print(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      print('object: $e');
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        ApiUrls.login,
        body: {'email': email, 'password': password},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print('result : ${result['data']['token']}');

        preferences.setString('token', result['data']['token']);
        preferences.setString('email', result['data']['email']);
        preferences.setString('status', result['data']['StatusName']);
        preferences.setString('user_type', result['data']['type'].toString());
        preferences.setInt('userId', result['data']['id']);

        if (result['data']['type'] == 1) {
          preferences.setString(
              'country', result['data']['location']['country']);
          preferences.setString('city', result['data']['location']['city']);
          preferences.setString(
              'lat', result['data']['location']['lat'].toString());
          preferences.setString(
              'long', result['data']['location']['long'].toString());

          if (result['data']['location']['address'] != null) {
            preferences.setString('address',
                result['data']['location']['address'] ?? 'no address given');
          }
        }

        return result;
      } else {
        print(response.statusCode);
        print(response.body);
        return result;
      }
    } catch (e) {
      print('error catch : $e');
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> verifyAccount(
      {required String email, required String code}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        ApiUrls.verifyAccount,
        body: {'email': email, 'code': code},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(response.body);
        prefs.setString('token', result['data']['token']);
        prefs.setString('email', result['data']['email']);
        prefs.setString('status', result['data']['StatusName']);
        prefs.setString('user_type', result['data']['type']);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> reSendCode({required String email}) async {
    try {
      final response = await http.post(
        ApiUrls.reSendCode,
        body: {'email': email},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(result);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> logOut(String token) async {
    try {
      final response = await http.post(ApiUrls.logOut,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(result);
      if (response.statusCode == 200) {
        return result['message'];
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}sendResetPassword');
      final response = await http.post(url, body: {'email': email});
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return 'Password sent ${result['message']}fully, please check your email';
      } else {
        return result['error'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
