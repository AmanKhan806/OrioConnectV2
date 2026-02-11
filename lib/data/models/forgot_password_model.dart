class ForgotPasswordResponseModel {
  final int status;
  final String message;

  ForgotPasswordResponseModel({
    required this.status,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}