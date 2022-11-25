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
