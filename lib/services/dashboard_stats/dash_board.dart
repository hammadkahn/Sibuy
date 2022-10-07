import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:http/http.dart' as http;

class DashBoardStats {
  Future<Map<String, dynamic>> getDashBoardStats(String token) async {
    try {
      final response = await http.get(
        ApiUrls.getDashStats,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //jsonDecode(response.body) as Map<String, dynamic>;

        return result;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
