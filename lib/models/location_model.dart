class LocationModel {
  int? id;
  int? userId;
  String? address;
  String? country;
  String? city;
  double? lat;
  double? long;
  String? createdAt;
  String? updatedAt;

  LocationModel(
      {this.id,
      this.userId,
      this.address,
      this.country,
      this.city,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address'] = address;
    data['country'] = country;
    data['city'] = city;
    data['lat'] = lat;
    data['long'] = long;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
