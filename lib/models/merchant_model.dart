import 'package:gigi_app/models/branch_model.dart';

import 'reviews_model.dart';

class MerchantSignUp {
  bool? status;
  int? responseCode;
  String? message;
  MerchantData? data;

  MerchantSignUp({this.status, this.responseCode, this.message, this.data});

  MerchantSignUp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? MerchantData.fromJson(json['data']) : null;
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

class MerchantList {
  bool? status;
  int? responseCode;
  String? message;
  List<MerchantData>? data;

  MerchantList({this.status, this.responseCode, this.message, this.data});

  MerchantList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MerchantData>[];
      json['data'].forEach((v) {
        data!.add(MerchantData.fromJson(v));
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

class SingleMerchant {
  bool? status;
  int? responseCode;
  String? message;
  MerchantData? data;

  SingleMerchant({this.status, this.responseCode, this.message, this.data});

  SingleMerchant.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? MerchantData.fromJson(json['data']) : null;
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

class MerchantData {
  int? id;
  String? name;
  dynamic gender;
  int? age;
  String? email;
  String? phone;
  dynamic dateOfBirth;
  dynamic emailVerifiedAt;
  String? profilePicture;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? activeOffers;
  int? dealRadeems;
  int? totalDealPurchase;
  int? totalCategories;
  List<BranchData>? branches;
  dynamic averageRating;
  List<Reviews>? reviews;
  String? profilePicturePath;
  String? statusName;

  MerchantData(
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
      this.activeOffers,
      this.dealRadeems,
      this.totalDealPurchase,
      this.totalCategories,
      this.branches,
      this.averageRating,
      this.reviews,
      this.profilePicturePath,
      this.statusName});

  MerchantData.fromJson(Map<String, dynamic> json) {
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
    activeOffers = json['activeOffers'];
    dealRadeems = json['dealRadeems'];
    totalDealPurchase = json['totalDealPurchase'];
    totalCategories = json['totalCategories'];
    if (json['branches'] != null) {
      branches = <BranchData>[];
      json['branches'].forEach((v) {
        branches!.add(BranchData.fromJson(v));
      });
    }
    averageRating = json['averageRating'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
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
    data['activeOffers'] = activeOffers;
    data['dealRadeems'] = dealRadeems;
    data['totalDealPurchase'] = totalDealPurchase;
    data['totalCategories'] = totalCategories;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['averageRating'] = averageRating;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['profilePicturePath'] = profilePicturePath;
    data['StatusName'] = statusName;
    return data;
  }
}
