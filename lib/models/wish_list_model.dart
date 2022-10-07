import 'package:gigi_app/models/image_model.dart';

class WishListModel {
  bool? status;
  int? responseCode;
  String? message;
  List<WishData>? data;

  WishListModel({this.status, this.responseCode, this.message, this.data});

  WishListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WishData>[];
      json['data'].forEach((v) {
        data!.add(WishData.fromJson(v));
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

class WishData {
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
  int? wishlistId;
  int? userId;
  ImageModel? image;

  WishData(
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
      this.wishlistId,
      this.userId,
      this.image});

  WishData.fromJson(Map<String, dynamic> json) {
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
    wishlistId = json['wishlist_id'];
    userId = json['user_id'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['wishlist_id'] = wishlistId;
    data['user_id'] = userId;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}
