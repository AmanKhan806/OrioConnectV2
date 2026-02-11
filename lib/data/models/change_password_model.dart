class ChangePasswordModel {
  final int status;
  final String message;
  final List<ChangePasswordPayload> payload;
  final String timestamp;

  ChangePasswordModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    List<ChangePasswordPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(ChangePasswordPayload.fromJson(item));
        }
      }
    }

    return ChangePasswordModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class ChangePasswordPayload {
  final String? message;

  ChangePasswordPayload({this.message});

  factory ChangePasswordPayload.fromJson(Map<String, dynamic> json) {
    return ChangePasswordPayload(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
