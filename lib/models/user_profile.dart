import 'package:uuid/uuid.dart';

class UserProfile {
  String? uuid;
  String? name;
  String? email;
  String? mobileNo;
  bool? admin;
  bool? paid;
  String? lastPaid;
  String? expired;
  int? overdue;

  UserProfile(
      {this.uuid,
      this.name,
      this.email,
      this.mobileNo,
      this.admin,
      this.paid,
      this.lastPaid,
      this.expired,
      this.overdue});

  UserProfile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    admin = json['admin'];
    paid = json['paid'];
    lastPaid = json['last_paid'];
    expired = json['expired'];
    overdue = json['overdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid ?? Uuid().v4();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['admin'] = this.admin ?? false;
    data['paid'] = this.paid;
    data['last_paid'] = this.lastPaid;
    data['expired'] = this.expired;
    data['overdue'] = this.overdue;
    return data;
  }
}
