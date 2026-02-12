class ChangePasswordModel {
  final int status;
  final String message;

  ChangePasswordModel({required this.status, required this.message});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}
