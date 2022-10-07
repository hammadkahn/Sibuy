class NotificationModel {
  bool? status;
  int? responseCode;
  String? message;
  List<Data>? data;

  NotificationModel({this.status, this.responseCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? typeId;
  String? type;
  String? subject;
  String? message;
  int? seen;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.typeId,
      this.type,
      this.subject,
      this.message,
      this.seen,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeId = json['type_id'];
    type = json['type'];
    subject = json['subject'];
    message = json['message'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['type_id'] = typeId;
    data['type'] = type;
    data['subject'] = subject;
    data['message'] = message;
    data['seen'] = seen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
