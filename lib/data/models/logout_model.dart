class LogoutModel {
  final int status;
  final String message;
  final String timestamp;

  LogoutModel({
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}
