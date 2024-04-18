
class OtpResponseModel {
  String? id;
  String? token;
  String? expires;
  String? now;

  OtpResponseModel({this.id, this.token, this.expires, this.now});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    expires = json['expires'];
    now = json['now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['expires'] = this.expires;
    data['now'] = this.now;
    return data;
  }
}