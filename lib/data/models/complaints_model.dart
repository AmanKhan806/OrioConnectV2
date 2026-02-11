import 'package:flutter/material.dart';

//Complaints Listing Model //
class ComplaintsListingModel {
  final int status;
  final String message;
  final List<ComplaintsListingPayload> payload;
  final String timestamp;

  ComplaintsListingModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory ComplaintsListingModel.fromJson(Map<String, dynamic> json) {
    List<ComplaintsListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(ComplaintsListingPayload.fromJson(item));
        }
      }
    }

    return ComplaintsListingModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class ComplaintsListingPayload {
  final int? total;
  final List<Complaints> complaints;

  ComplaintsListingPayload({this.total, required this.complaints});

  factory ComplaintsListingPayload.fromJson(Map<String, dynamic> json) {
    List<Complaints> complaintsList = [];

    if (json['complaints'] != null && json['complaints'] is List) {
      final advancesData = json['complaints'] as List;
      for (var item in advancesData) {
        if (item is Map<String, dynamic>) {
          complaintsList.add(Complaints.fromJson(item));
        }
      }
    }

    return ComplaintsListingPayload(
      total: json['total'],
      complaints: complaintsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'complaints': complaints.map((e) => e.toJson()).toList(),
    };
  }
}

class Complaints {
  final int? id;
  final String? empno;
  final String? empname;
  final String? subject;
  final String? complaint;
  final String? status;
  final String? createdOn;
  final String? resolvedOn;
  final String? resolvedBy;
  final String? comments;

  Complaints({
    this.id,
    this.empno,
    this.empname,
    this.subject,
    this.complaint,
    this.status,
    this.createdOn,
    this.resolvedOn,
    this.resolvedBy,
    this.comments,
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
    return Complaints(
      id: json['id'],
      empno: json['empno'],
      empname: json['empname'],
      subject: json['subject'],
      complaint: json['complaint'],
      status: json['status'],
      createdOn: json['created_on'],
      resolvedOn: json['resolved_on'],
      resolvedBy: json['resolved_by'],
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'empno': empno,
      'empname': empname,
      'subject': subject,
      'complaint': complaint,
      'status': status,
      'created_on': createdOn,
      'resolved_on': resolvedOn,
      'resolved_by': resolvedBy,
      'comments': comments,
    };
  }

  Color get statusColor {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'in-progress':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'rejected':
        return Colors.red;
      case 'resolved':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String get displayStatus => status ?? 'Unknown';
}
//Complaints Listing Model //

// Create Complaints Model //
class CreateComplaintsModel {
  final int status;
  final String message;
  final String timestamp;

  CreateComplaintsModel({
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory CreateComplaintsModel.fromJson(Map<String, dynamic> json) {
    return CreateComplaintsModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

// Create Complaints Model //
