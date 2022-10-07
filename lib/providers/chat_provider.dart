import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/current_user_chat_model.dart';
import 'package:http/http.dart' as http;

class Conversation {
  bool? status;
  int? responseCode;
  String? message;
  List<ChatData>? data;

  Conversation({this.status, this.responseCode, this.message, this.data});

  Conversation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatData>[];
      json['data'].forEach((v) {
        data!.add(ChatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['responseCode'] = responseCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatData {
  int? id;
  int? firstUser;
  int? secondUser;
  String? createdAt;
  String? updatedAt;
  int? unReadCount;
  LastMessage? lastMessage;
  OppositeUser? oppositeUser;

  ChatData(
      {this.id,
      this.firstUser,
      this.secondUser,
      this.createdAt,
      this.updatedAt,
      this.unReadCount,
      this.lastMessage,
      this.oppositeUser});

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstUser = json['first_user'];
    secondUser = json['second_user'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unReadCount = json['un_readCount'];
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    oppositeUser = json['opposite_user'] != null
        ? OppositeUser.fromJson(json['opposite_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_user'] = firstUser;
    data['second_user'] = secondUser;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['un_readCount'] = unReadCount;
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    if (oppositeUser != null) {
      data['opposite_user'] = oppositeUser!.toJson();
    }
    return data;
  }
}

class SingleConversation {
  bool? status;
  int? responseCode;
  String? message;
  SingleChatData? data;

  SingleConversation({this.status, this.responseCode, this.message, this.data});

  SingleConversation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? SingleChatData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['responseCode'] = responseCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SingleChatData {
  int? id;
  String? firstUser;
  String? secondUser;
  String? createdAt;
  String? updatedAt;
  int? unReadCount;
  OppositeUser? oppositeUser;

  SingleChatData(
      {this.id,
      this.firstUser,
      this.secondUser,
      this.createdAt,
      this.updatedAt,
      this.unReadCount,
      this.oppositeUser});

  SingleChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstUser = json['first_user'];
    secondUser = json['second_user'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unReadCount = json['un_readCount'];
    oppositeUser = json['opposite_user'] != null
        ? OppositeUser.fromJson(json['opposite_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_user'] = firstUser;
    data['second_user'] = secondUser;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['un_readCount'] = unReadCount;
    if (oppositeUser != null) {
      data['opposite_user'] = oppositeUser!.toJson();
    }
    return data;
  }
}

class LastMessage {
  int? id;
  int? conversationId;
  int? userId;
  String? message;
  dynamic attachment;
  int? seen;
  String? createdAt;
  String? updatedAt;

  LastMessage(
      {this.id,
      this.conversationId,
      this.userId,
      this.message,
      this.attachment,
      this.seen,
      this.createdAt,
      this.updatedAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    message = json['message'];
    attachment = json['attachment'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversation_id'] = conversationId;
    data['user_id'] = userId;
    data['message'] = message;
    data['attachment'] = attachment;
    data['seen'] = seen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class OppositeUser {
  int? id;
  String? name;
  int? type;
  String? profilePicture;
  String? profilePicturePath;
  dynamic statusName;

  OppositeUser(
      {this.id,
      this.name,
      this.type,
      this.profilePicture,
      this.profilePicturePath,
      this.statusName});

  OppositeUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    profilePicture = json['profile_picture'];
    profilePicturePath = json['profilePicturePath'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['profile_picture'] = profilePicture;
    data['profilePicturePath'] = profilePicturePath;
    data['StatusName'] = statusName;
    return data;
  }
}

class ChatProvider with ChangeNotifier {
  String? _conversationId;
  Conversation? _conversation;
  SingleConversation? _singleConversation;
  CurrentUserConversation? _currentUserConversation;

  Conversation get conversation => _conversation!;
  SingleConversation get singleConversation => _singleConversation!;
  CurrentUserConversation get currentUserConversation =>
      _currentUserConversation!;

  String get conversationId => _conversationId!;

  Future<Conversation> getAllConversation(String token) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}getConversations');
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final result = Conversation.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _conversation = result;
        notifyListeners();
        return result;
      } else {
        debugPrint(response.reasonPhrase);

        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage(String token, String msg, String id) async {
    try {
      debugPrint('$token, $msg, $id');
      final url = Uri.parse('${ApiUrls.baseUrl}sendMessage/$id');
      final response = await http.post(
        url,
        body: {'message': msg},
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        notifyListeners();
      } else {
        debugPrint(response.reasonPhrase);

        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getSingleConversation(
      String token, String id) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiUrls.baseUrl}getConversation/$id'),
          headers: {HttpHeaders.authorizationHeader: 'Bear $token'});
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        // _singleConversation = result;
        notifyListeners();
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CurrentUserConversation> getCurrentConversation(
      String token, String id) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiUrls.baseUrl}getConversationMessages/$id'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      final result =
          CurrentUserConversation.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        debugPrint('current user : ${result.data!.length}');
        // _currentUserConversation = result;
        return result;
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> createCoversation(String token, String msg) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}createConversation');
      final response = await http.post(
        url,
        body: {'message': msg, 'receiver': '1'},
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        debugPrint(response.body);
        _conversationId = result['data']['id'];
        return result['data']['id'].toString();
      } else {
        debugPrint(response.reasonPhrase);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
