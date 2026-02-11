import 'package:flutter/material.dart';

class AttendanceHistoryModel {
  final int status;
  final String message;
  final List<AttendanceHistoryListingPayload> payload;
  final String timestamp;

  AttendanceHistoryModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    List<AttendanceHistoryListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(AttendanceHistoryListingPayload.fromJson(item));
        }
      }
    }

    return AttendanceHistoryModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class AttendanceHistoryListingPayload {
  final String? empno;
  final String? period;
  final int? totalRecords;
  final List<AttendanceHistory> records;

  AttendanceHistoryListingPayload({
    this.empno,
    this.period,
    this.totalRecords,
    required this.records,
  });

  factory AttendanceHistoryListingPayload.fromJson(Map<String, dynamic> json) {
    List<AttendanceHistory> historyList = [];

    if (json['records'] != null && json['records'] is List) {
      final historyData = json['records'] as List;
      for (var item in historyData) {
        if (item is Map<String, dynamic>) {
          historyList.add(AttendanceHistory.fromJson(item));
        }
      }
    }

    return AttendanceHistoryListingPayload(
      empno: json['empno'],
      period: json['period'],
      totalRecords: json['total_records'],
      records: historyList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empno': empno,
      'period': period,
      'total_records': totalRecords,
      'records': records.map((e) => e.toJson()).toList(),
    };
  }
}

class AttendanceHistory {
  final String? empno;
  final String? date;
  final String? day;
  final String? inTime;
  final String? outTime;
  final String? totalHours;
  final String? overtime;
  final String? status;
  final String? channel;
  final String? remark;

  AttendanceHistory({
    this.empno,
    this.date,
    this.day,
    this.inTime,
    this.outTime,
    this.totalHours,
    this.overtime,
    this.status,
    this.channel,
    this.remark,
  });

  factory AttendanceHistory.fromJson(Map<String, dynamic> json) {
    return AttendanceHistory(
      empno: json['empno'],
      date: json['date'],
      day: json['day'],
      inTime: json['intime'],
      outTime: json['outtime'],
      totalHours: json['total_hours'],
      overtime: json['overtime'],
      status: json['status'],
      channel: json['channel'],
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empno': empno,
      'date': date,
      'day': day,
      'intime': inTime,
      'outtime': outTime,
      'total_hours': totalHours,
      'overtime': overtime,
      'status': status,
      'channel': channel,
      'remark': remark,
    };
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'holiday':
        return Colors.purple;
      case 'gazette holiday':
        return Colors.blue;
      case 'present':
        return Colors.green;
      case 'late':
        return Colors.orange;
      case 'leave':
        return Colors.amber;
      case 'absent':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }
}
