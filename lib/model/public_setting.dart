class PublicSetting {
  Support? support;

  PublicSetting({this.support});

  PublicSetting.fromJson(Map<String, dynamic>? json) {
    support =
    json!['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}

class Support {
  int? whatsappMobile;
  String? email;
  int? mobile;

  Support({this.whatsappMobile, this.email, this.mobile});

  Support.fromJson(Map<String, dynamic> json) {
    whatsappMobile = json['whatsappMobile'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['whatsappMobile'] = whatsappMobile;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}
