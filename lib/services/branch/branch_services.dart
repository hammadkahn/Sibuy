import 'dart:convert';
import 'dart:io';

import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/branch_model.dart';
import 'package:http/http.dart' as http;

class BranchServices {
  Future<AllBranches> getAllBranches({required String token}) async {
    try {
      final response = await http.get(
        ApiUrls.getAllBranches,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        return AllBranches.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getBranchesList({required String token}) async {
    try {
      final response = await http.get(
        ApiUrls.getAllBranches,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return result;
      } else {
        print(response.statusCode);
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
