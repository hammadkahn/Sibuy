import 'dart:convert';
import 'dart:io';

import 'package:SiBuy/models/dashbaord_stats_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:http/http.dart' as http;

class DashBoardStats {
  Future<DashboardStatsModel> getDashBoardStats(String token) async {
    try {
      final response = await http.get(
        ApiUrls.getDashStats,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      print(response.body);
      final result = DashboardStatsModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
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
