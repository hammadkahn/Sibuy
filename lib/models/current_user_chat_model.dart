class CurrentUserConversation {
  bool? status;
  int? responseCode;
  String? message;
  List<Data>? data;

  CurrentUserConversation(
      {this.status, this.responseCode, this.message, this.data});

  CurrentUserConversation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? conversationId;
  int? userId;
  String? message;
  dynamic attachment;
  int? seen;
  String? createdAt;
  String? updatedAt;
  User? user;

  Data(
      {this.id,
      this.conversationId,
      this.userId,
      this.message,
      this.attachment,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    message = json['message'];
    attachment = json['attachment'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? type;
  String? profilePicture;
  String? profilePicturePath;
  dynamic statusName;

  User(
      {this.id,
      this.name,
      this.type,
      this.profilePicture,
      this.profilePicturePath,
      this.statusName});

  User.fromJson(Map<String, dynamic> json) {
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
