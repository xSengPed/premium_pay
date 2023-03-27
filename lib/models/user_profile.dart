class UserProfile {
  String? gmail;
  bool? isAdmin;
  bool? paid;
  String? tel;
  String? uid;
  int? value;

  UserProfile(
      {this.gmail, this.isAdmin, this.paid, this.tel, this.uid, this.value});

  UserProfile.fromJson(Map<String, dynamic> json) {
    gmail = json['gmail'];
    isAdmin = json['isAdmin'];
    paid = json['paid'];
    tel = json['tel'];
    uid = json['uid'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gmail'] = this.gmail;
    data['isAdmin'] = this.isAdmin;
    data['paid'] = this.paid;
    data['tel'] = this.tel;
    data['uid'] = this.uid;
    data['value'] = this.value;
    return data;
  }
}
