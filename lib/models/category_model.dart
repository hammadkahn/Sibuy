import 'package:gigi_app/models/deal_model.dart';

import 'image_model.dart';

class GetAllCategoriesModel {
  bool? status;
  int? responseCode;
  String? message;
  List<CategoryData>? data;

  GetAllCategoriesModel(
      {this.status, this.responseCode, this.message, this.data});

  GetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class CategoryData {
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  CategoryData(
      {this.id,
      this.name,
      this.image,
      this.parentId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.imagePath});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parentId = json['parent_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['parent_id'] = parentId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['imagePath'] = imagePath;
    return data;
  }
}

class SearchModel {
  bool? status;
  int? responseCode;
  String? message;
  List<DealData>? data;

  SearchModel({this.status, this.responseCode, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DealData>[];
      json['data'].forEach((v) {
        data!.add(DealData.fromJson(v));
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

class SearchData {
  int? id;
  String? name;
  String? discount;
  String? type;
  String? price;
  String? additionalDiscount;
  String? additionalDiscountDate;
  String? discountOnPrice;
  String? afterDiscount;
  String? actualPrice;
  String? categoryId;
  String? description;
  String? status;
  String? rejectReason;
  String? active;
  String? activiationRequest;
  String? merchantId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? expiry;
  String? merchantName;
  String? categoryName;
  ImageModel? image;
  int? dealIsExpired;
  String? typeName;
  String? activationRequestFor;

  SearchData(
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
      this.merchantName,
      this.categoryName,
      this.image,
      this.dealIsExpired,
      this.typeName,
      this.activationRequestFor});

  SearchData.fromJson(Map<String, dynamic> json) {
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
    merchantName = json['merchant_name'];
    categoryName = json['category_name'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
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
    data['merchant_name'] = merchantName;
    data['category_name'] = categoryName;
    if (image != null) {
      data['image'] = image!.toJson();
    }
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
