import 'dart:convert';
import 'dart:io';

import 'package:gigi_app/apis/api_urls.dart';
import 'package:http/http.dart' as http;

class ReviewsServices {
  Future<Map<String, dynamic>> writeReview(
      String token, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiUrls.baseUrl}user/addReview'),
          body: data,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
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
}
