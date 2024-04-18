

class LoginModel {
  String? otpRequestId;
  int? otp;
  String? userId;
  int? statusCode;
  String? error;
  bool? isNew=false;

  LoginModel({this.otpRequestId, this.otp, this.userId, this.statusCode,this.error,this.isNew});

  LoginModel.fromJson(Map<String, dynamic> json) {
    otpRequestId = json['otpRequestId'];
    otp = json['otp'];
    userId = json['userId'];
    statusCode = json['statusCode'];
    error = json['error'];
    isNew = json['isNew'] ?? false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpRequestId'] = otpRequestId;
    data['otp'] = otp;
    data['userId'] = userId;
    data['statusCode'] = statusCode;
    data['error'] = error;
    data['isNew'] = isNew;

    return data;
  }
}
