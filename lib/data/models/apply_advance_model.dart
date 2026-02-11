import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckAdvanceModel {
  final int status;
  final String message;
  final List<CheckAdvancePayload> payload;
  final String timestamp;

  CheckAdvanceModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory CheckAdvanceModel.fromJson(Map<String, dynamic> json) {
    List<CheckAdvancePayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(CheckAdvancePayload.fromJson(item));
        }
      }
    }

    return CheckAdvanceModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class CheckAdvancePayload {
  final String? empno;
  final String? name;
  final String? designation;
  final String? department;
  final String? location;
  final int? grossSalary;
  final String? doj;
  final int? daysWorked;
  final int? salaryForDays;
  final int? previousAdvanceThisMonth;
  final int? advanceAllowed;
  final bool? canApply;

  CheckAdvancePayload({
    this.empno,
    this.name,
    this.designation,
    this.department,
    this.location,
    this.grossSalary,
    this.doj,
    this.daysWorked,
    this.salaryForDays,
    this.previousAdvanceThisMonth,
    this.advanceAllowed,
    this.canApply,
  });

  factory CheckAdvancePayload.fromJson(Map<String, dynamic> json) {
    return CheckAdvancePayload(
      empno: json['empno'],
      name: json['name'],
      designation: json['designation'],
      department: json['department'],
      location: json['location'],
      grossSalary: json['gross_salary'],
      doj: json['doj'],
      daysWorked: json['days_worked'],
      salaryForDays: json['salary_for_days'],
      previousAdvanceThisMonth: json['previous_advance_this_month'],
      advanceAllowed: json['advance_allowed'],
      canApply: json['can_apply'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empno': empno,
      'name': name,
      'designation': designation,
      'department': department,
      'location': location,
      'gross_salary': grossSalary,
      'doj': doj,
      'days_worked': daysWorked,
      'salary_for_days': salaryForDays,
      'previous_advance_this_month': previousAdvanceThisMonth,
      'advance_allowed': advanceAllowed,
      'can_apply': canApply,
    };
  }

  String get formattedName => name ?? '--';

  String get formattedDesignation => designation ?? '--';

  String get formattedDepartment => department ?? '--';

  String get formattedLocation => location ?? '--';

  String get formattedDoj => doj ?? '--';

  String get formattedGrossSalary {
    if (grossSalary == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(grossSalary)}';
  }

  String get formattedDaysWorked {
    if (daysWorked == null) return '0 days';
    return '$daysWorked ${daysWorked == 1 ? 'day' : 'days'}';
  }

  String get formattedSalaryForDays {
    if (salaryForDays == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(salaryForDays)}';
  }

  String get formattedPreviousAdvance {
    if (previousAdvanceThisMonth == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(previousAdvanceThisMonth)}';
  }

  String get formattedAdvanceAllowed {
    if (advanceAllowed == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(advanceAllowed)}';
  }
}

class AdvanceListingModel {
  final int status;
  final String message;
  final List<AdvanceListingPayload> payload;
  final String timestamp;

  AdvanceListingModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory AdvanceListingModel.fromJson(Map<String, dynamic> json) {
    List<AdvanceListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(AdvanceListingPayload.fromJson(item));
        }
      }
    }

    return AdvanceListingModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

// Listing Model//
class AdvanceListingPayload {
  final int? total;
  final List<Advance> advances;

  AdvanceListingPayload({this.total, required this.advances});

  factory AdvanceListingPayload.fromJson(Map<String, dynamic> json) {
    List<Advance> advancesList = [];

    if (json['advances'] != null && json['advances'] is List) {
      final advancesData = json['advances'] as List;
      for (var item in advancesData) {
        if (item is Map<String, dynamic>) {
          advancesList.add(Advance.fromJson(item));
        }
      }
    }

    return AdvanceListingPayload(total: json['total'], advances: advancesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'advances': advances.map((e) => e.toJson()).toList(),
    };
  }
}

class Advance {
  final int? advanceId;
  final String? empno;
  final String? empname;
  final int? amount;
  final String? reason;
  final String? status;
  final int? previousAdvance;
  final String? createdOn;
  final String? approvedOn;
  final String? approvedBy;
  final String? fncApprovalDate;

  Advance({
    this.advanceId,
    this.empno,
    this.empname,
    this.amount,
    this.reason,
    this.status,
    this.previousAdvance,
    this.createdOn,
    this.approvedOn,
    this.approvedBy,
    this.fncApprovalDate,
  });

  factory Advance.fromJson(Map<String, dynamic> json) {
    return Advance(
      advanceId: json['advance_id'],
      empno: json['empno'],
      empname: json['empname'],
      amount: json['amount'],
      reason: json['reason'],
      status: json['status'],
      previousAdvance: json['previous_advance'],
      createdOn: json['created_on'],
      approvedOn: json['approved_on'],
      approvedBy: json['approved_by'],
      fncApprovalDate: json['fnc_approval_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'advance_id': advanceId,
      'empno': empno,
      'empname': empname,
      'amount': amount,
      'reason': reason,
      'status': status,
      'previous_advance': previousAdvance,
      'created_on': createdOn,
      'approved_on': approvedOn,
      'approved_by': approvedBy,
      'fnc_approval_date': fncApprovalDate,
    };
  }

  String get formattedAmount {
    if (amount == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(amount)}';
  }

  String get formattedCreatedOn {
    if (createdOn == null || createdOn!.isEmpty) return '--';
    try {
      final date = DateTime.parse(createdOn!);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return createdOn ?? '--';
    }
  }

  String get formattedApprovedOn {
    if (approvedOn == null || approvedOn!.isEmpty) return '--';
    try {
      final date = DateTime.parse(approvedOn!);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return approvedOn ?? '--';
    }
  }

  String get formattedReason => reason ?? '--';

  String get formattedEmpname {
    if (empname == null || empname!.isEmpty || empname == '--') {
      return '--';
    }
    return empname!;
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

  String get displayStatus => status ?? 'Unknown';
}

///Create Advance Model\\
class CreateAdvanceResponseModel {
  final int status;
  final String message;
  final List<CreateAdvancePayload> payload;
  final String timestamp;

  CreateAdvanceResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory CreateAdvanceResponseModel.fromJson(Map<String, dynamic> json) {
    List<CreateAdvancePayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(CreateAdvancePayload.fromJson(item));
        }
      }
    }

    return CreateAdvanceResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class CreateAdvancePayload {
  final int? id;
  final int? amount;
  final String? status;

  CreateAdvancePayload({this.id, this.amount, this.status});

  factory CreateAdvancePayload.fromJson(Map<String, dynamic> json) {
    return CreateAdvancePayload(
      id: json['advance_id'],
      amount: json['amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'advance_id': id, 'amount': amount, 'status': status};
  }
}
///Create Advance Model\\