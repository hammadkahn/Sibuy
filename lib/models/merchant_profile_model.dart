import 'package:SiBuy/models/reviews_model.dart';

class ProfileModel {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  ProfileModel({this.status, this.responseCode, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? name;
  dynamic gender;
  int? age;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? promoCode;
  int? referBy;
  dynamic emailVerifiedAt;
  String? profilePicture;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? averageRating;
  List<Reviews>? reviews;
  int? activeOffers;
  int? dealRadeems;
  int? totalDealPurchase;
  int? totalCategories;
  List<BusinessDetails>? businessDetails;
  List<UserLocations>? userLocations;
  List<UserLanguages>? userLanguages;
  String? profilePicturePath;
  String? statusName;

  Data(
      {this.id,
      this.name,
      this.gender,
      this.age,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.promoCode,
      this.referBy,
      this.emailVerifiedAt,
      this.profilePicture,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.averageRating,
      this.reviews,
      this.activeOffers,
      this.dealRadeems,
      this.totalDealPurchase,
      this.totalCategories,
      this.businessDetails,
      this.userLocations,
      this.userLanguages,
      this.profilePicturePath,
      this.statusName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    promoCode = json['promo_code'];
    referBy = json['refer_by'];
    emailVerifiedAt = json['email_verified_at'];
    profilePicture = json['profile_picture'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['averageRating'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    activeOffers = json['activeOffers'];
    dealRadeems = json['dealRadeems'];
    totalDealPurchase = json['totalDealPurchase'];
    totalCategories = json['totalCategories'];
    if (json['businessDetails'] != null) {
      businessDetails = <BusinessDetails>[];
      json['businessDetails'].forEach((v) {
        businessDetails!.add(BusinessDetails.fromJson(v));
      });
    }
    if (json['userLocations'] != null) {
      userLocations = <UserLocations>[];
      json['userLocations'].forEach((v) {
        userLocations!.add(UserLocations.fromJson(v));
      });
    }
    if (json['userLanguages'] != null) {
      userLanguages = <UserLanguages>[];
      json['userLanguages'].forEach((v) {
        userLanguages!.add(UserLanguages.fromJson(v));
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
    data['promo_code'] = promoCode;
    data['refer_by'] = referBy;
    data['email_verified_at'] = emailVerifiedAt;
    data['profile_picture'] = profilePicture;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['averageRating'] = averageRating;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['activeOffers'] = activeOffers;
    data['dealRadeems'] = dealRadeems;
    data['totalDealPurchase'] = totalDealPurchase;
    data['totalCategories'] = totalCategories;
    if (businessDetails != null) {
      data['businessDetails'] =
          businessDetails!.map((v) => v.toJson()).toList();
    }
    if (userLocations != null) {
      data['userLocations'] = userLocations!.map((v) => v.toJson()).toList();
    }
    if (userLanguages != null) {
      data['userLanguages'] = userLanguages!.map((v) => v.toJson()).toList();
    }
    data['profilePicturePath'] = profilePicturePath;
    data['StatusName'] = statusName;
    return data;
  }
}

class BusinessDetails {
  int? id;
  List<String>? operatingDays;
  String? openingTime;
  String? closingTime;
  String? isRegisteredWithMinistryOfCommerce;
  String? registrationNumber;
  String? documentPath;
  List<Documents>? documents;

  BusinessDetails(
      {this.id,
      this.operatingDays,
      this.openingTime,
      this.closingTime,
      this.isRegisteredWithMinistryOfCommerce,
      this.registrationNumber,
      this.documentPath,
      this.documents});

  BusinessDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operatingDays = json['operating_days'].cast<String>();
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    isRegisteredWithMinistryOfCommerce =
        json['is_registered_with_ministry_of_commerce'];
    registrationNumber = json['registration_number'];
    documentPath = json['documentPath'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['operating_days'] = operatingDays;
    data['opening_time'] = openingTime;
    data['closing_time'] = closingTime;
    data['is_registered_with_ministry_of_commerce'] =
        isRegisteredWithMinistryOfCommerce;
    data['registration_number'] = registrationNumber;
    data['documentPath'] = documentPath;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  int? id;
  String? documentPath;

  Documents({this.id, this.documentPath});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentPath = json['document_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['document_path'] = documentPath;
    return data;
  }
}

class UserLocations {
  int? id;
  String? address;
  String? countryId;
  String? countryName;
  String? cityId;
  String? cityName;
  double? lat;
  double? long;

  UserLocations(
      {this.id,
      this.address,
      this.countryId,
      this.countryName,
      this.cityId,
      this.cityName,
      this.lat,
      this.long});

  UserLocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

class UserLanguages {
  int? id;
  int? isDefault;
  int? languageId;
  String? languageCode;
  String? languageName;

  UserLanguages(
      {this.id,
      this.isDefault,
      this.languageId,
      this.languageCode,
      this.languageName});

  UserLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDefault = json['is_default'];
    languageId = json['languageId'];
    languageCode = json['languageCode'];
    languageName = json['languageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_default'] = isDefault;
    data['languageId'] = languageId;
    data['languageCode'] = languageCode;
    data['languageName'] = languageName;
    return data;
  }
}
