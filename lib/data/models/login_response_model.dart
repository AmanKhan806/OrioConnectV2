class LoginResponseModel {
  final int status;
  final String message;
  final List<LoginPayload> payload;
  final String timestamp;

  LoginResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    List<LoginPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(LoginPayload.fromJson(item));
        }
      }
    }

    return LoginResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
  LoginPayload? get firstPayload => payload.isNotEmpty ? payload.first : null;
}

class LoginPayload {
  final String? username;
  final String? otp;

  LoginPayload({
    this.username,
    this.otp,
  });

  factory LoginPayload.fromJson(Map<String, dynamic> json) {
    return LoginPayload(
      username: json['username'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'otp': otp,
    };
  }
}
