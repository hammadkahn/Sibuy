class QrModel {
  int? dEALID;
  String? deal;
  String? merchant;
  String? discount;
  String? type;
  String? actualPrice;
  String? price;
  String? afterDiscount;

  QrModel(
      {this.dEALID,
      this.deal,
      this.merchant,
      this.discount,
      this.type,
      this.actualPrice,
      this.price,
      this.afterDiscount});

  QrModel.fromJson(Map<String, dynamic> json) {
    dEALID = json['DEALID'];
    deal = json['Deal'];
    merchant = json['Merchant'];
    discount = json['Discount'];
    type = json['Type'];
    actualPrice = json['Actual Price'];
    price = json['Price'];
    afterDiscount = json['After Discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DEALID'] = dEALID;
    data['Deal'] = deal;
    data['Merchant'] = merchant;
    data['Discount'] = discount;
    data['Type'] = type;
    data['Actual Price'] = actualPrice;
    data['Price'] = price;
    data['After Discount'] = afterDiscount;
    return data;
  }
}
