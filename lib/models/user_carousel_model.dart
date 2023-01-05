class UserCarouselData {
  bool? status;
  int? responseCode;
  String? message;
  List<UserCarousel>? data;

  UserCarouselData({this.status, this.responseCode, this.message, this.data});

  UserCarouselData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserCarousel>[];
      json['data'].forEach((v) {
        data!.add(UserCarousel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCarousel {
  int? id;
  String? headText;
  String? lowerText;
  String? link;
  String? image;
  int? status;
  int? addedBy;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  UserCarousel(
      {this.id,
        this.headText,
        this.lowerText,
        this.link,
        this.image,
        this.status,
        this.addedBy,
        this.createdAt,
        this.updatedAt,
        this.imagePath});

  UserCarousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headText = json['head_text'];
    lowerText = json['lower_text'];
    link = json['link'];
    image = json['image'];
    status = json['status'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['head_text'] = this.headText;
    data['lower_text'] = this.lowerText;
    data['link'] = this.link;
    data['image'] = this.image;
    data['status'] = this.status;
    data['added_by'] = this.addedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['imagePath'] = this.imagePath;
    return data;
  }
}