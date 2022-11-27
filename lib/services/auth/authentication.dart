import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MerchantAuthServices {
  Future<Map<String, dynamic>> merchantRegisteration(
      {required Map<String, dynamic> data}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiUrls.baseUrl}merchantRegister'));
      request.fields.addAll({
        'name': data['name'],
        'email': data['email'],
        'phone_no': data['phone_no'],
        'password': data['password'],
        'password_confirmation': data['password_confirmation'],
        'address': data['address'],
        'country': data['country'],
        'city': data['city'],
        'categories[0]': data['categories[0]'],
        'categories[1]': data['categories[1]'],
        'language': data['language'],
        'operation_days': data['operation_days'],
        'opnening_time': data['opnening_time'],
        'closing_time': data['closing_time'],
        'is_registered_with_ministry_of_commerce':
            data['is_registered_with_ministry_of_commerce'],
        'registration_number': data['registration_number'],
        'patent_number': data['parent_number'],
      });
      request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', data['profile_picture']));
      request.files
          .add(await http.MultipartFile.fromPath('logo', data['logo']));
      request.files.add(await http.MultipartFile.fromPath(
          'documents[0]', data['documents[0]']));
      request.files.add(await http.MultipartFile.fromPath(
          'documents[1]', data['documents[1]']));

      http.StreamedResponse response = await request.send();
      final result = await http.Response.fromStream(response);
      final responseData = jsonDecode(result.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        log(result.body);
        return responseData;
      } else {
        print(response.reasonPhrase);
        return responseData;
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
        body: {'phone_no': email, 'password': password},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print('result : ${result['data']['token']}');

        preferences.setString('token', result['data']['token']);
        preferences.setString('email', result['data']['phone']);
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

  Future<String> changePassword(
    String token,
    String currPass,
    String newPass,
    String confirmPass,
  ) async {
    try {
      print('$token, $currPass, $newPass, $confirmPass');
      final response = await http.post(ApiUrls.changePass, body: {
        'old_password': currPass,
        'password': newPass,
        'password_confirmation': confirmPass,
      }, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return result['meassge'];
      } else {
        return response.reasonPhrase.toString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
