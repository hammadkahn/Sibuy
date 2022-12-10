import 'package:SiBuy/models/image_model.dart';

import 'location_model.dart';
import 'merchant_single_deal.dart';

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
  dynamic name;
  dynamic gender;
  int? age;
  dynamic email;
  dynamic phone;
  dynamic dateOfBirth;
  dynamic promoCode;
  int? referBy;
  dynamic emailVerifiedAt;
  dynamic profilePicture;
  int? type;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic language;
  List<LocationModel>? userLocations;
  List<Perference>? perference;
  UserPoints? points;
  dynamic profilePicturePath;
  dynamic statusName;

  UserProfileData(
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
      this.language,
      this.userLocations,
      this.perference,
      this.points,
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
    promoCode = json['promo_code'];
    referBy = json['refer_by'];
    emailVerifiedAt = json['email_verified_at'];
    profilePicture = json['profile_picture'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'];
    if (json['userLocations'] != null) {
      userLocations = <LocationModel>[];
      json['userLocations'].forEach((v) {
        userLocations!.add(LocationModel.fromJson(v));
      });
    }
    if (json['perference'] != null) {
      perference = <Perference>[];
      json['perference'].forEach((v) {
        perference!.add(Perference.fromJson(v));
      });
    }
    points =
        json['points'] != null ? UserPoints.fromJson(json['points']) : null;
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
    data['language'] = language;
    if (userLocations != null) {
      data['userLocations'] = userLocations!.map((v) => v.toJson()).toList();
    }
    if (perference != null) {
      data['perference'] = perference!.map((v) => v.toJson()).toList();
    }
    if (points != null) {
      data['points'] = points!.toJson();
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

class UserLocationsModel {
  bool? status;
  int? responseCode;
  String? message;
  List<UserLocationData>? data;

  UserLocationsModel({this.status, this.responseCode, this.message, this.data});

  UserLocationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserLocationData>[];
      json['data'].forEach((v) {
        data!.add(UserLocationData.fromJson(v));
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

class UserLocationData {
  int? id;
  String? address;
  int? countryId;
  String? countryName;
  int? cityId;
  String? cityName;
  dynamic lat;
  dynamic long;

  UserLocationData(
      {this.id,
      this.address,
      this.countryId,
      this.countryName,
      this.cityId,
      this.cityName,
      this.lat,
      this.long});

  UserLocationData.fromJson(Map<String, dynamic> json) {
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

class UserDealListModel {
  bool? status;
  int? responseCode;
  String? message;
  List<UserDealListData>? data;

  UserDealListModel({this.status, this.responseCode, this.message, this.data});

  UserDealListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserDealListData>[];
      json['data'].forEach((v) {
        data!.add(UserDealListData.fromJson(v));
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

class UserDealListData {
  int? id;
  String? name;
  int? discount;
  String? type;
  int? price;
  int? additionalDiscount;
  dynamic additionalDiscountDate;
  int? discountOnPrice;
  int? afterDiscount;
  int? actualPrice;
  int? categoryId;
  int? limit;
  String? description;
  int? status;
  String? rejectReason;
  int? active;
  int? activiationRequest;
  int? merchantId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? expiry;
  String? redeemExpiry;
  String? isRedeemExpiryNotificationDispatch;
  int? isSponsored;
  String? languageId;
  String? isUpdated;
  String? merchantName;
  String? categoryName;
  ImageModel? image;
  dynamic reviewAndCount;
  Products? products;
  String? isLikedDeal;
  int? dealIsExpired;
  String? typeName;
  String? activationRequestFor;

  UserDealListData(
      {this.id,
      this.name,
      this.discount,
      this.type,
      this.price,
      this.additionalDiscount,
      this.additionalDiscountDate,
      this.discountOnPrice,
      this.afterDiscount,
      this.actualPrice,
      this.categoryId,
      this.limit,
      this.description,
      this.status,
      this.rejectReason,
      this.active,
      this.activiationRequest,
      this.merchantId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.expiry,
      this.redeemExpiry,
      this.isRedeemExpiryNotificationDispatch,
      this.isSponsored,
      this.languageId,
      this.isUpdated,
      this.merchantName,
      this.categoryName,
      this.image,
      this.reviewAndCount,
      this.products,
      this.isLikedDeal,
      this.dealIsExpired,
      this.typeName,
      this.activationRequestFor});

  UserDealListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    type = json['type'];
    price = json['price'];
    additionalDiscount = json['additional_discount'];
    additionalDiscountDate = json['additional_discount_date'];
    discountOnPrice = json['discount_on_price'];
    afterDiscount = json['after_discount'];
    actualPrice = json['actual_price'];
    categoryId = json['category_id'];
    limit = json['limit'];
    description = json['description'];
    status = json['status'];
    rejectReason = json['reject_reason'];
    active = json['active'];
    activiationRequest = json['activiation_request'];
    merchantId = json['merchant_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiry = json['expiry'];
    redeemExpiry = json['redeem_expiry'];
    isRedeemExpiryNotificationDispatch =
        json['is_redeem_expiry_notification_dispatch'];
    isSponsored = json['is_sponsored'];
    languageId = json['language_id'];
    isUpdated = json['is_updated'];
    merchantName = json['merchant_name'];
    categoryName = json['category_name'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    reviewAndCount = json['reviewAndCount'];
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
    isLikedDeal = json['isLikedDeal'];
    dealIsExpired = json['dealIsExpired'];
    typeName = json['TypeName'];
    activationRequestFor = json['activationRequestFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['discount'] = discount;
    data['type'] = type;
    data['price'] = price;
    data['additional_discount'] = additionalDiscount;
    data['additional_discount_date'] = additionalDiscountDate;
    data['discount_on_price'] = discountOnPrice;
    data['after_discount'] = afterDiscount;
    data['actual_price'] = actualPrice;
    data['category_id'] = categoryId;
    data['limit'] = limit;
    data['description'] = description;
    data['status'] = status;
    data['reject_reason'] = rejectReason;
    data['active'] = active;
    data['activiation_request'] = activiationRequest;
    data['merchant_id'] = merchantId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['expiry'] = expiry;
    data['redeem_expiry'] = redeemExpiry;
    data['is_redeem_expiry_notification_dispatch'] =
        isRedeemExpiryNotificationDispatch;
    data['is_sponsored'] = isSponsored;
    data['language_id'] = languageId;
    data['is_updated'] = isUpdated;
    data['merchant_name'] = merchantName;
    data['category_name'] = categoryName;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['reviewAndCount'] = reviewAndCount;
    if (products != null) {
      data['products'] = products!.toJson();
    }
    data['isLikedDeal'] = isLikedDeal;
    data['dealIsExpired'] = dealIsExpired;
    data['TypeName'] = typeName;
    data['activationRequestFor'] = activationRequestFor;
    return data;
  }
}

class UserSingleDealModel {
  bool? status;
  int? responseCode;
  String? message;
  UserSingleDealData? data;

  UserSingleDealModel(
      {this.status, this.responseCode, this.message, this.data});

  UserSingleDealModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data =
        json['data'] != null ? UserSingleDealData.fromJson(json['data']) : null;
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

class UserSingleDealData {
  int? id;
  String? name;
  int? discount;
  String? type;
  int? price;
  int? additionalDiscount;
  dynamic additionalDiscountDate;
  int? discountOnPrice;
  int? afterDiscount;
  int? actualPrice;
  int? categoryId;
  int? limit;
  String? description;
  int? status;
  String? rejectReason;
  int? active;
  int? activiationRequest;
  int? merchantId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? expiry;
  String? redeemExpiry;
  String? isRedeemExpiryNotificationDispatch;
  int? isSponsored;
  String? languageId;
  String? isUpdated;
  List<ImageModel>? images;
  List<Tags>? tags;
  ReviewAndCount? reviewAndCount;
  Products? products;
  String? isLikedDeal;
  int? dealIsExpired;
  String? typeName;
  String? activationRequestFor;

  UserSingleDealData(
      {this.id,
      this.name,
      this.discount,
      this.type,
      this.price,
      this.additionalDiscount,
      this.additionalDiscountDate,
      this.discountOnPrice,
      this.afterDiscount,
      this.actualPrice,
      this.categoryId,
      this.limit,
      this.description,
      this.status,
      this.rejectReason,
      this.active,
      this.activiationRequest,
      this.merchantId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.expiry,
      this.redeemExpiry,
      this.isRedeemExpiryNotificationDispatch,
      this.isSponsored,
      this.languageId,
      this.isUpdated,
      this.images,
      this.tags,
      this.reviewAndCount,
      this.products,
      this.isLikedDeal,
      this.dealIsExpired,
      this.typeName,
      this.activationRequestFor});

  UserSingleDealData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    type = json['type'];
    price = json['price'];
    additionalDiscount = json['additional_discount'];
    additionalDiscountDate = json['additional_discount_date'];
    discountOnPrice = json['discount_on_price'];
    afterDiscount = json['after_discount'];
    actualPrice = json['actual_price'];
    categoryId = json['category_id'];
    limit = json['limit'];
    description = json['description'];
    status = json['status'];
    rejectReason = json['reject_reason'];
    active = json['active'];
    activiationRequest = json['activiation_request'];
    merchantId = json['merchant_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiry = json['expiry'];
    redeemExpiry = json['redeem_expiry'];
    isRedeemExpiryNotificationDispatch =
        json['is_redeem_expiry_notification_dispatch'];
    isSponsored = json['is_sponsored'];
    languageId = json['language_id'];
    isUpdated = json['is_updated'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    if (reviewAndCount != null) {
      json['reviewAndCount'] = reviewAndCount!.toJson();
    }
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
    isLikedDeal = json['isLikedDeal'];
    dealIsExpired = json['dealIsExpired'];
    typeName = json['TypeName'];
    activationRequestFor = json['activationRequestFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['discount'] = discount;
    data['type'] = type;
    data['price'] = price;
    data['additional_discount'] = additionalDiscount;
    data['additional_discount_date'] = additionalDiscountDate;
    data['discount_on_price'] = discountOnPrice;
    data['after_discount'] = afterDiscount;
    data['actual_price'] = actualPrice;
    data['category_id'] = categoryId;
    data['limit'] = limit;
    data['description'] = description;
    data['status'] = status;
    data['reject_reason'] = rejectReason;
    data['active'] = active;
    data['activiation_request'] = activiationRequest;
    data['merchant_id'] = merchantId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['expiry'] = expiry;
    data['redeem_expiry'] = redeemExpiry;
    data['is_redeem_expiry_notification_dispatch'] =
        isRedeemExpiryNotificationDispatch;
    data['is_sponsored'] = isSponsored;
    data['language_id'] = languageId;
    data['is_updated'] = isUpdated;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (reviewAndCount != null) {
      data['reviewAndCount'] = reviewAndCount!.toJson();
    }
    if (products != null) {
      data['products'] = products!.toJson();
    }
    data['isLikedDeal'] = isLikedDeal;
    data['dealIsExpired'] = dealIsExpired;
    data['TypeName'] = typeName;
    data['activationRequestFor'] = activationRequestFor;
    return data;
  }
}

class LanguageModel {
  int? languageId;
  String? languageName;
  String? languageCode;

  LanguageModel({this.languageId, this.languageName, this.languageCode});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    languageId = json['languageId'];
    languageName = json['languageName'];
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['languageName'] = languageName;
    data['languageCode'] = languageCode;
    return data;
  }
}

class UserPoints {
  int? userId;
  int? points;

  UserPoints({this.userId, this.points});

  UserPoints.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['points'] = points;
    return data;
  }
}

class ReviewAndCount {
  int? count;
  String? rating;

  ReviewAndCount({this.count, this.rating});

  ReviewAndCount.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['rating'] = rating;
    return data;
  }
}
