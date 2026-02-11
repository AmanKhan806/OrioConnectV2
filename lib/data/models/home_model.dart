// check_in_response_model.dart
class CheckInResponseModel {
  final int status;
  final String message;
  final List<CheckInData> payload;
  final String timestamp;

  CheckInResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory CheckInResponseModel.fromJson(Map<String, dynamic> json) {
    List<CheckInData> payloadList = [];
    
    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(CheckInData.fromJson(item));
        }
      }
    }
    
    return CheckInResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
  CheckInData? get data => payload.isNotEmpty ? payload.first : null;
}

class CheckInData {
  final String empno;
  final String date;
  final String intime;
  final String? outtime;
  final String? status;

  CheckInData({
    required this.empno,
    required this.date,
    required this.intime,
    this.outtime,
    this.status,
  });

  factory CheckInData.fromJson(Map<String, dynamic> json) {
    return CheckInData(
      empno: json['empno']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      intime: json['intime']?.toString() ?? '',
      outtime: json['outtime']?.toString(),
      status: json['status']?.toString(),
    );
  }
}

// today_attendance_response_model.dart
class TodayAttendanceResponseModel {
  final int status;
  final String message;
  final List<TodayAttendanceData> payload;
  final String timestamp;

  TodayAttendanceResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory TodayAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    List<TodayAttendanceData> payloadList = [];
    
    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(TodayAttendanceData.fromJson(item));
        }
      }
    }
    
    return TodayAttendanceResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
  TodayAttendanceData? get data => payload.isNotEmpty ? payload.first : null;
}

class TodayAttendanceData {
  final String? intime;
  final String? outtime;
  final String? workingHours;
  final String? status;

  TodayAttendanceData({
    this.intime,
    this.outtime,
    this.workingHours,
    this.status,
  });

  factory TodayAttendanceData.fromJson(Map<String, dynamic> json) {
    return TodayAttendanceData(
      intime: json['intime']?.toString(),
      outtime: json['outtime']?.toString(),
      workingHours: json['working_hours']?.toString(),
      status: json['status']?.toString(),
    );
  }
}

// attendance_summary_response_model.dart
class AttendanceSummaryResponseModel {
  final int status;
  final String message;
  final List<AttendanceSummaryData> payload;
  final String timestamp;

  AttendanceSummaryResponseModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory AttendanceSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    List<AttendanceSummaryData> payloadList = [];
    
    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(AttendanceSummaryData.fromJson(item));
        }
      }
    }
    
    return AttendanceSummaryResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
  AttendanceSummaryData? get data => payload.isNotEmpty ? payload.first : null;
}

class AttendanceSummaryData {
  final String empno;
  final int totalWorkingDays;
  final int totalDays;
  final int present;
  final int onTime;
  final int late;
  final int absent;
  final int casualLeave;
  final int annualLeave;
  final int sickLeave;
  final int unpaidLeave;
  final String period;

  AttendanceSummaryData({
    required this.empno,
    required this.totalWorkingDays,
    required this.totalDays,
    required this.present,
    required this.onTime,
    required this.late,
    required this.absent,
    required this.casualLeave,
    required this.annualLeave,
    required this.sickLeave,
    required this.unpaidLeave,
    required this.period,
  });

  factory AttendanceSummaryData.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryData(
      empno: json['empno']?.toString() ?? '',
      totalWorkingDays: int.tryParse(json['total_working_days']?.toString() ?? '0') ?? 0,
      totalDays: int.tryParse(json['total_days']?.toString() ?? '0') ?? 0,
      present: int.tryParse(json['present']?.toString() ?? '0') ?? 0,
      onTime: int.tryParse(json['on_time']?.toString() ?? '0') ?? 0,
      late: int.tryParse(json['late']?.toString() ?? '0') ?? 0,
      absent: int.tryParse(json['absent']?.toString() ?? '0') ?? 0,
      casualLeave: int.tryParse(json['casual_leave']?.toString() ?? '0') ?? 0,
      annualLeave: int.tryParse(json['annual_leave']?.toString() ?? '0') ?? 0,
      sickLeave: int.tryParse(json['sick_leave']?.toString() ?? '0') ?? 0,
      unpaidLeave: int.tryParse(json['unpaid_leave']?.toString() ?? '0') ?? 0,
      period: json['period']?.toString() ?? '',
    );
  }
}