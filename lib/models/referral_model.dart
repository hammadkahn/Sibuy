import 'package:SiBuy/models/current_user_chat_model.dart';

class ReferralModel {
  String? referralCode;
  List<User>? users;

  ReferralModel({this.referralCode, this.users});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    referralCode = json['referralCode'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referralCode'] = this.referralCode;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
