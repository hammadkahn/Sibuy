class UserProfileModel {
  bool? status;
  int? responseCode;
  String? message;
  UserProfileData? data;

  UserProfileModel({this.status, this.responseCode, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
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

class UserProfileData {
  int? id;
  String? name;
  String? gender;
  int? age;
  String? email;
  String? phone;
  String? dateOfBirth;
  dynamic emailVerifiedAt;
  String? profilePicture;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Perference>? perference;
  String? profilePicturePath;
  String? statusName;

  UserProfileData(
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
      this.perference,
      this.profilePicturePath,
      this.statusName});

  UserProfileData.fromJson(Map<String, dynamic> json) {
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
    if (json['perference'] != null) {
      perference = <Perference>[];
      json['perference'].forEach((v) {
        perference!.add(Perference.fromJson(v));
      });
    }
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
    if (perference != null) {
      data['perference'] = perference!.map((v) => v.toJson()).toList();
    }
    data['profilePicturePath'] = profilePicturePath;
    data['StatusName'] = statusName;
    return data;
  }
}

class Perference {
  int? id;
  int? userId;
  int? categoryId;
  String? categoryName;
  String? createdAt;
  String? updatedAt;

  Perference(
      {this.id,
      this.userId,
      this.categoryId,
      this.categoryName,
      this.createdAt,
      this.updatedAt});

  Perference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
