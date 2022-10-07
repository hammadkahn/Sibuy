import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/models/notification.dart';
import 'package:http/http.dart' as http;

import '../apis/api_urls.dart';

class NotificationServices {
  Future<NotificationModel> getNotifications({required String token}) async {
    try {
      final url = Uri.parse(
          '${ApiUrls.baseUrl}getNotifications?limit=&page=&timeSort=desc&toDate&fromDate');
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = NotificationModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint(result.responseCode.toString());
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> groupNotifications({required String token}) async {
    try {
      final url = Uri.parse(
          '${ApiUrls.baseUrl}getDateWiseNotification?timeSort=desc&toDate&fromDate');
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
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
