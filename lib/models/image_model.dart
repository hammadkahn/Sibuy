class ImageModel {
  int? id;
  int? dealId;
  String? originalName;
  String? path;
  String? image;
  String? createdAt;
  String? updatedAt;

  ImageModel(
      {this.id,
      this.dealId,
      this.originalName,
      this.path,
      this.image,
      this.createdAt,
      this.updatedAt});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    originalName = json['original_name'];
    path = json['path'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_id'] = dealId;
    data['original_name'] = originalName;
    data['path'] = path;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
