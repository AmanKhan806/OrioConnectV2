import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Leave Balance Model //
class LeaveBalanceModel {
  final int status;
  final String message;
  final List<LeaveBalancePayload> payload;
  final String timestamp;

  LeaveBalanceModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    List<LeaveBalancePayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(LeaveBalancePayload.fromJson(item));
        }
      }
    }

    return LeaveBalanceModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class LeaveBalancePayload {
  final int? casualEarned;
  final int? casualTaken;
  final int? casualavailable;
  final int? sickEarned;
  final int? sickTaken;
  final int? sickavailable;
  final int? annualEarned;
  final int? annualTaken;
  final int? annualAvailable;

  LeaveBalancePayload({
    this.casualEarned,
    this.casualTaken,
    this.casualavailable,
    this.sickEarned,
    this.sickTaken,
    this.sickavailable,
    this.annualEarned,
    this.annualTaken,
    this.annualAvailable,
  });

  factory LeaveBalancePayload.fromJson(Map<String, dynamic> json) {
    return LeaveBalancePayload(
      casualEarned: json['casual_earned'],
      casualTaken: json['casual_taken'],
      casualavailable: json['casual_available'],
      sickEarned: json['sick_earned'],
      sickTaken: json['sick_taken'],
      sickavailable: json['sick_available'],
      annualEarned: json['annual_earned'],
      annualTaken: json['annual_taken'],
      annualAvailable: json['annual_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casual_earned': casualEarned,
      'casual_taken': casualTaken,
      'casual_available': casualavailable,
      'sick_earned': sickEarned,
      'sick_taken': sickTaken,
      'sick_available': sickavailable,
      'annual_earned': annualEarned,
      'annual_taken': annualTaken,
      'annual_available': annualAvailable,
    };
  }
}
//Leave Balance Model //


// Leave Listing Model//
class LeaveListingModel {
  final int status;
  final String message;
  final List<LeaveListingPayload> payload;
  final String timestamp;

  LeaveListingModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory LeaveListingModel.fromJson(Map<String, dynamic> json) {
    List<LeaveListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(LeaveListingPayload.fromJson(item));
        }
      }
    }

    return LeaveListingModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class LeaveListingPayload {
  final int? total;
  final List<LeaveListing> leaveList;

  LeaveListingPayload({this.total, required this.leaveList});

  factory LeaveListingPayload.fromJson(Map<String, dynamic> json) {
    List<LeaveListing> leaveList = [];

    if (json['records'] != null && json['records'] is List) {
      final leaveListData = json['records'] as List;
      for (var item in leaveListData) {
        if (item is Map<String, dynamic>) {
          leaveList.add(LeaveListing.fromJson(item));
        }
      }
    }

    return LeaveListingPayload(total: json['total'], leaveList: leaveList);
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'records': leaveList.map((e) => e.toJson()).toList(),
    };
  }
}

class LeaveListing {
  final int? id;
  final String? empno;
  final String? startDate;
  final String? typeLeave;
  final String? comments;
  final String? endDate;
  final String? appliedOn;
  final dynamic reviewBy;
  final String? reviewOn;
  final String? isActive;
  final String? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final String? leaveStatus;

  LeaveListing({
    this.id,
    this.empno,
    this.startDate,
    this.typeLeave,
    this.comments,
    this.endDate,
    this.appliedOn,
    this.reviewBy,
    this.reviewOn,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.leaveStatus,
  });

  factory LeaveListing.fromJson(Map<String, dynamic> json) {
    return LeaveListing(
      id: json['id'],
      empno: json['empno'],
      startDate: json['startdate'],
      typeLeave: json['typeleave'],
      comments: json['comments'],
      endDate: json['enddate'],
      appliedOn: json['applied_on'],
      reviewBy: json['review_by'],
      reviewOn: json['review_on'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      leaveStatus: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'empno': empno,
      'startdate': startDate,
      'typeleave': typeLeave,
      'comments': comments,
      'enddate': endDate,
      'applied_on': appliedOn,
      'review_by': reviewBy,
      'review_on': reviewOn,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': leaveStatus,
    };
  }

 

  String get formattedCreatedOn {
    if (createdAt == null || createdAt!.isEmpty) return '--';
    try {
      final date = DateTime.parse(createdAt!);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return createdAt ?? '--';
    }
  }

  String get formattedUpdatedOn {
    if (updatedAt == null || updatedAt!.isEmpty) return '--';
    try {
      final date = DateTime.parse(updatedAt!);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return updatedAt ?? '--';
    }
  }


  Color get statusColor {
    switch (leaveStatus?.toLowerCase()) {
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

  Color get typeLeaveColor {
    switch (typeLeave?.toLowerCase()) {
      case 'casual':
        return Colors.green;
      case 'sick':
        return Colors.orange;
      case 'annual':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String get displayStatus => leaveStatus ?? 'Unknown';

  String get displayTypeLeave => typeLeave ?? 'Unknown';

}
// Leave Listing Model//


// Create Leave Model//
class CreateLeaveModel {
  final int status;
  final String message;
  final String timestamp;

  CreateLeaveModel({
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory   CreateLeaveModel.fromJson(Map<String, dynamic> json) {
    return CreateLeaveModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}
// Create Leave Model//
