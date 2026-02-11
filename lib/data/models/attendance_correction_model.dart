import 'package:flutter/material.dart';

class AttendanceCorrectionModel {
  final int status;
  final String message;
  final List<AttendanceCorrectionListingPayload> payload;
  final String timestamp;

  AttendanceCorrectionModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory AttendanceCorrectionModel.fromJson(Map<String, dynamic> json) {
    List<AttendanceCorrectionListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(AttendanceCorrectionListingPayload.fromJson(item));
        }
      }
    }

    return AttendanceCorrectionModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class AttendanceCorrectionListingPayload {
  final int? total;
  final List<AttendanceCorrection> correction;

  AttendanceCorrectionListingPayload({this.total, required this.correction});

  factory AttendanceCorrectionListingPayload.fromJson(
    Map<String, dynamic> json,
  ) {
    List<AttendanceCorrection> correctionList = [];

    if (json['correction'] != null && json['correction'] is List) {
      final recordsData = json['correction'] as List;
      for (var item in recordsData) {
        if (item is Map<String, dynamic>) {
          correctionList.add(AttendanceCorrection.fromJson(item));
        }
      }
    }

    return AttendanceCorrectionListingPayload(
      total: json['total'],
      correction: correctionList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'correction': correction.map((e) => e.toJson()).toList(),
    };
  }
}

class AttendanceCorrection {
  final int? id;
  final String? empno;
  final String? date;
  final String? type;
  final String? checkIn;
  final String? checkOut;
  final String? reason;
  final String? status;
  final String? remarks;
  final String? reviewedBy;
  final String? reviewedOn;

  AttendanceCorrection({
    this.id,
    this.empno,
    this.date,
    this.type,
    this.checkIn,
    this.checkOut,
    this.reason,
    this.status,
    this.remarks,
    this.reviewedBy,
    this.reviewedOn,
  });

  factory AttendanceCorrection.fromJson(Map<String, dynamic> json) {
    return AttendanceCorrection(
      id: json['id'],
      empno: json['empno'],
      date: json['date'],
      type: json['type'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      reason: json['reason'],
      status: json['status'],
      remarks: json['remarks'],
      reviewedBy: json['reviewed_by'],
      reviewedOn: json['reviewed_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'empno': empno,
      'date': date,
      'type': type,
      'check_in': checkIn,
      'check_out': checkOut,
      'reason': reason,
      'status': status,
      'remarks': remarks,
      'reviewed_by': reviewedBy,
      'reviewed_on': reviewedOn,
    };
  }

  Color get statusColor {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get typeColor {
    switch (type) {
      case 'MISSED_CHECK_IN':
        return const Color(0xFFFFA726);
      case 'MISSED_CHECK_OUT':
        return const Color(0xFFF57C00);
      case 'WRONG_TIME':
        return const Color(0xFFE53935);
      case 'BOTH':
        return const Color(0xFF8E24AA);
      case 'WORK_FROM_HOME':
        return const Color(0xFF1E88E5);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  String get typeConvertString {
    switch (type) {
      case 'MISSED_CHECK_IN':
        return "Missed Check In";
      case 'MISSED_CHECK_OUT':
        return "Missed Check Out";
      case 'WRONG_TIME':
        return "Wrong Time";
      case 'BOTH':
        return "Both";
      case 'WORK_FROM_HOME':
        return "Work From Home";
      default:
        return "";
    }
  }

  String get displayType => typeConvertString;

  String get displayStatus => status ?? 'Unknown';

  String get formattedCheckIn {
    if (checkIn == null || checkIn!.isEmpty || checkIn == '0000') {
      return 'N/A';
    }
    
    try {
      if (checkIn!.length == 4) {
        final hour = int.parse(checkIn!.substring(0, 2));
        final minute = checkIn!.substring(2, 4);
        
        if (hour == 0) {
          return '12:$minute AM';
        } else if (hour < 12) {
          return '$hour:$minute AM';
        } else if (hour == 12) {
          return '12:$minute PM';
        } else {
          return '${hour - 12}:$minute PM';
        }
      }
      return checkIn!;
    } catch (e) {
      return checkIn!;
    }
  }

  String get formattedCheckOut {
    if (checkOut == null || checkOut!.isEmpty || checkOut == '0000') {
      return 'N/A';
    }
    
    try {
      if (checkOut!.length == 4) {
        final hour = int.parse(checkOut!.substring(0, 2));
        final minute = checkOut!.substring(2, 4);
        
        if (hour == 0) {
          return '12:$minute AM';
        } else if (hour < 12) {
          return '$hour:$minute AM';
        } else if (hour == 12) {
          return '12:$minute PM';
        } else {
          return '${hour - 12}:$minute PM';
        }
      }
      return checkOut!;
    } catch (e) {
      return checkOut!;
    }
  }
}