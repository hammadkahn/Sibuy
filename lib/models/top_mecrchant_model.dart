class TopMerchantModel {
  bool? status;
  int? responseCode;
  String? message;
  List<TopMerchantData>? data;

  TopMerchantModel({this.status, this.responseCode, this.message, this.data});

  TopMerchantModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TopMerchantData>[];
      json['data'].forEach((v) {
        data!.add(TopMerchantData.fromJson(v));
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

class TopMerchantData {
  int? id;
  String? name;
  String? gender;
  dynamic age;
  String? email;
  String? phone;
  dynamic dateOfBirth;
  dynamic emailVerifiedAt;
  String? profilePicture;
  dynamic type;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  dynamic averageRating;
  String? profilePicturePath;
  String? statusName;

  TopMerchantData(
      {this.id,
      this.name,
      this.gender,
      this.age,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.emailVerifiedAt,
      this.profilePicture,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.averageRating,
      this.profilePicturePath,
      this.statusName});

  TopMerchantData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    emailVerifiedAt = json['email_verified_at'];
    profilePicture = json['profile_picture'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['averageRating'];
    profilePicturePath = json['profilePicturePath'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['email'] = email;
    data['phone'] = phone;
    data['date_of_birth'] = dateOfBirth;
    data['email_verified_at'] = emailVerifiedAt;
    data['profile_picture'] = profilePicture;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['averageRating'] = averageRating;
    data['profilePicturePath'] = profilePicturePath;
    data['StatusName'] = statusName;
    return data;
  }
}
