class OfficeWifiModel {
  final int status;
  final String message;
  final List<OfficeWifiPayload> payload;

  OfficeWifiModel({
    required this.status,
    required this.message,
    required this.payload,
  });

  factory OfficeWifiModel.fromJson(Map<String, dynamic> json) {
    List<OfficeWifiPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(OfficeWifiPayload.fromJson(item));
        }
      }
    }

    return OfficeWifiModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
    );
  }

  bool get isSuccess => status == 1;
}

class OfficeWifiPayload {
  final int? id;
  final String? name;
  final String? password;

  OfficeWifiPayload({
    this.id,
    this.name,
    this.password,
  });

  factory OfficeWifiPayload.fromJson(Map<String, dynamic> json) {
    return OfficeWifiPayload(
      id: json['id'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }
}