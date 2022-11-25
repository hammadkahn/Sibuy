import 'package:SiBuy/models/image_model.dart';

class SingleDealModel {
  bool? status;
  int? responseCode;
  String? message;
  MerchantSingleDealData? data;

  SingleDealModel({this.status, this.responseCode, this.message, this.data});

  SingleDealModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null
        ? MerchantSingleDealData.fromJson(json['data'])
        : null;
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

class MerchantSingleDealData {
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
  String? uniqueCode;
  String? languageId;
  String? categoryName;
  String? languageName;
  List<ImageModel>? images;
  List<Tags>? tags;
  List<Products>? products;
  dynamic reviewAndCount;
  int? dealIsExpired;
  String? typeName;
  String? activationRequestFor;

  MerchantSingleDealData(
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
      this.uniqueCode,
      this.languageId,
      this.categoryName,
      this.languageName,
      this.images,
      this.tags,
      this.products,
      this.reviewAndCount,
      this.dealIsExpired,
      this.typeName,
      this.activationRequestFor});

  MerchantSingleDealData.fromJson(Map<String, dynamic> json) {
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
    uniqueCode = json['unique_code'];
    languageId = json['language_id'];
    categoryName = json['category_name'];
    languageName = json['language_name'];
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
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    reviewAndCount = json['reviewAndCount'];
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
    data['unique_code'] = uniqueCode;
    data['language_id'] = languageId;
    data['category_name'] = categoryName;
    data['language_name'] = languageName;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['reviewAndCount'] = reviewAndCount;
    data['dealIsExpired'] = dealIsExpired;
    data['TypeName'] = typeName;
    data['activationRequestFor'] = activationRequestFor;
    return data;
  }
}

class Tags {
  int? id;
  int? dealId;
  String? tag;
  String? createdAt;
  String? updatedAt;

  Tags({this.id, this.dealId, this.tag, this.createdAt, this.updatedAt});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    tag = json['tag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_id'] = dealId;
    data['tag'] = tag;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Products {
  int? id;
  int? dealId;
  String? productName;
  String? productPrice;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id,
      this.dealId,
      this.productName,
      this.productPrice,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_id'] = dealId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
