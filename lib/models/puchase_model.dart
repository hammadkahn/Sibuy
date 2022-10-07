import 'package:gigi_app/models/cart_model.dart';

class SinglePurchaseModel {
  bool? status;
  int? responseCode;
  String? message;
  CartData? data;

  SinglePurchaseModel(
      {this.status, this.responseCode, this.message, this.data});

  SinglePurchaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
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
