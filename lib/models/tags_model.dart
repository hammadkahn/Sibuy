class Tags {
  int? id;
  String? dealId;
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
