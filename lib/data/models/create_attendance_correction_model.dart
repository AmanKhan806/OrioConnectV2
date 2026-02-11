///Create Attendance Correction Model\\
class CreateAttendanceCorrectionResponseModel {
  final int status;
  final String message;
  final List<CreateAttendanceCorrectionPayload> payload;
  final String timestamp;

  CreateAttendanceCorrectionResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory CreateAttendanceCorrectionResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<CreateAttendanceCorrectionPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(CreateAttendanceCorrectionPayload.fromJson(item));
        }
      }
    }

    return CreateAttendanceCorrectionResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class CreateAttendanceCorrectionPayload {
  final int? requestId;
  final String? message;

  CreateAttendanceCorrectionPayload({this.requestId, this.message});

  factory CreateAttendanceCorrectionPayload.fromJson(
    Map<String, dynamic> json,
  ) {
    return CreateAttendanceCorrectionPayload(
      requestId: json['request_id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'request_id': requestId, 'message': message};
  }
}
