class AllBranches {
  bool? status;
  int? responseCode;
  String? message;
  List<BranchData>? data;

  AllBranches({this.status, this.responseCode, this.message, this.data});

  AllBranches.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BranchData>[];
      json['data'].forEach((v) {
        data!.add(BranchData.fromJson(v));
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

class BranchData {
  int? id;
  String? name;
  String? address;
  String? country;
  String? city;
  String? lat;
  String? long;
  String? description;
  String? logo;
  int? status;
  int? active;
  int? merchantId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? logoPath;
  BranchData(
      {this.id,
      this.name,
      this.address,
      this.country,
      this.city,
      this.lat,
      this.long,
      this.description,
      this.logo,
      this.status,
      this.active,
      this.merchantId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.logoPath});

  BranchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    lat = json['lat'];
    long = json['long'];
    description = json['description'];
    logo = json['logo'];
    status = json['status'];
    active = json['active'];
    merchantId = json['merchant_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logoPath = json['logoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['country'] = country;
    data['city'] = city;
    data['lat'] = lat;
    data['long'] = long;
    data['description'] = description;
    data['logo'] = logo;
    data['status'] = status;
    data['active'] = active;
    data['merchant_id'] = merchantId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['logoPath'] = logoPath;
    return data;
  }
}
