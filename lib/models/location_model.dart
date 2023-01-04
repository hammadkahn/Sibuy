class LocationModel {
  int? id;
  int? userId;
  String? address;
  String? cityName;
  String? countryName;
  String? countryId;
  String? cityId;
  double? lat;
  double? long;
  String? createdAt;
  String? updatedAt;

  LocationModel(
      {this.id,
      this.userId,
      this.address,
      this.countryName,
      this.cityName,
      this.countryId,
      this.cityId,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    countryName = json['countryName'];
    countryId = json['countryId'].toString();
    cityId = json['cityId'].toString();
    cityName = json['cityName'];
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
    data['cityName'] = cityName;
    data['countryName'] = countryName;
    data['cityId'] = cityId;
    data['countryId'] = countryId;
    data['lat'] = lat;
    data['long'] = long;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
