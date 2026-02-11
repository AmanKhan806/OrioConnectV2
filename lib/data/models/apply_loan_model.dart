//Apply Loan Listing Model//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplyLoanModel {
  final int status;
  final String message;
  final List<ApplyLoanListingPayload> payload;
  final String timestamp;

  ApplyLoanModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory ApplyLoanModel.fromJson(Map<String, dynamic> json) {
    List<ApplyLoanListingPayload> payloadList = [];

    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(ApplyLoanListingPayload.fromJson(item));
        }
      }
    }

    return ApplyLoanModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class ApplyLoanListingPayload {
  final int? total;
  final List<ApplyLoan> records;

  ApplyLoanListingPayload({this.total, required this.records});

  factory ApplyLoanListingPayload.fromJson(Map<String, dynamic> json) {
    List<ApplyLoan> recordsList = [];

    if (json['records'] != null && json['records'] is List) {
      final recordsData = json['records'] as List;
      for (var item in recordsData) {
        if (item is Map<String, dynamic>) {
          recordsList.add(ApplyLoan.fromJson(item));
        }
      }
    }

    return ApplyLoanListingPayload(total: json['total'], records: recordsList);
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'records': records.map((e) => e.toJson()).toList()};
  }
}

class ApplyLoan {
  final int? loanId;
  final String? empno;
  final String? empname;
  final String? designation;
  final String? department;
  final String? location;
  final int? grossSalary;
  final int? amount;
  final dynamic monthlyDeduction;
  final dynamic remaining;
  final int? totalInstallment;
  final int? paidInstallment;
  final int? pendingInstallment;
  final String? status;
  final String? approvedBy;
  final String? approvedOn;
  final String? hrComments;
  final String? createdOn;
  final String? endsOn;

  ApplyLoan({
    this.loanId,
    this.empno,
    this.empname,
    this.designation,
    this.department,
    this.location,
    this.grossSalary,
    this.amount,
    this.monthlyDeduction,
    this.remaining,
    this.totalInstallment,
    this.paidInstallment,
    this.pendingInstallment,
    this.status,
    this.approvedBy,
    this.approvedOn,
    this.hrComments,
    this.createdOn,
    this.endsOn,
  });

  factory ApplyLoan.fromJson(Map<String, dynamic> json) {
    return ApplyLoan(
      loanId: json['loan_id'],
      empno: json['empno'],
      empname: json['empname'],
      designation: json['designation'],
      department: json['department'],
      location: json['location'],
      grossSalary: json['gross_salary'],
      amount: json['amount'],
      monthlyDeduction: json['monthly_deduction'],
      remaining: json['remaining'],
      totalInstallment: json['total_installments'],
      paidInstallment: json['paid_installments'],
      pendingInstallment: json['pending_installments'],
      status: json['status'],
      approvedBy: json['approved_by'],
      approvedOn: json['approved_on'],
      hrComments: json['hr_comments'],
      createdOn: json['created_on'],
      endsOn: json['ends_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_id': loanId,
      'empno': empno,
      'empname': empname,
      'designation': designation,
      'department': department,
      'location': location,
      'gross_salary': grossSalary,
      'amount': amount,
      'monthly_deduction': monthlyDeduction,
      'remaining': remaining,
      'total_installments': totalInstallment,
      'paid_installments': paidInstallment,
      'pending_installments': pendingInstallment,
      'status': status,
      'approved_by': approvedBy,
      'approved_on': approvedOn,
      'hr_comments': hrComments,
      'created_on': createdOn,
      'ends_on': endsOn,
    };
  }

  String get formattedAmount {
    if (amount == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(amount)}';
  }

  String get formatteGrossSalary {
    if (grossSalary == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(grossSalary)}';
  }

  String get formatteMonthlyDeduction {
    if (monthlyDeduction == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(monthlyDeduction)}';
  }

  String get formatteRemaining {
    if (remaining == null) return 'PKR 0';
    final formatter = NumberFormat('#,##,###', 'en_PK');
    return 'PKR ${formatter.format(remaining)}';
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

//Apply Loan Listing Model//


//Create Laon Model //
class CreateLoanModel {
  final int status;
  final String message;
  final String timestamp;

  CreateLoanModel({
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory CreateLoanModel.fromJson(Map<String, dynamic> json) {
    return CreateLoanModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}
//Create Laon Model //
