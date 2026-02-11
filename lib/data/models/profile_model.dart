class ProfileModel {
  final int status;
  final String message;
  final List<ProfileData> payload;
  final String timestamp;

  ProfileModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: (json['payload'] as List<dynamic>?)
              ?.map((item) => ProfileData.fromJson(item))
              .toList() ??
          [],
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class ProfileData {
  final String empno;
  final String ename;
  final String fname;
  final String address;
  final String cnic;
  final String email;
  final String gender;
  final String mobile;
  final String dob;
  final String desgdesc;
  final String dname;
  final String location;
  final String shift;
  final String shiftCode;
  final String shiftStartTime;
  final String shiftEndTime;
  final String shifttype;
  final String cnicIssuedate;
  final String imgurl;

  ProfileData({
    required this.empno,
    required this.ename,
    required this.fname,
    required this.address,
    required this.cnic,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.dob,
    required this.desgdesc,
    required this.dname,
    required this.location,
    required this.shift,
    required this.shiftCode,
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.shifttype,
    required this.cnicIssuedate,
    required this.imgurl,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      empno: json['empno'] ?? '',
      ename: json['ename'] ?? '',
      fname: json['fname'] ?? '',
      address: json['address'] ?? '',
      cnic: json['cnic'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      mobile: json['mobile'] ?? '',
      dob: json['dob'] ?? '',
      desgdesc: json['desgdesc'] ?? '',
      dname: json['dname'] ?? '',
      location: json['location'] ?? '',
      shift: json['shift'] ?? '',
      shiftCode: json['shift_code'] ?? '',
      shiftStartTime: json['shift_start_time'] ?? '',
      shiftEndTime: json['shift_end_time'] ?? '',
      shifttype: json['shifttype'] ?? '',
      cnicIssuedate: json['cnic_issuedate'] ?? '',
      imgurl: json['imgurl'] ?? '',
    );
  }
}

class UpdateProfileModel {
  final int status;
  final String message;
  final String timestamp;

  UpdateProfileModel({
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class UploadImageModel {
  final int status;
  final String message;
  final List<ImageData> payload;
  final String timestamp;

  UploadImageModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.timestamp,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) {
    return UploadImageModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: (json['payload'] as List<dynamic>?)
              ?.map((item) => ImageData.fromJson(item))
              .toList() ??
          [],
      timestamp: json['timestamp'] ?? '',
    );
  }

  bool get isSuccess => status == 1;
}

class ImageData {
  final String imgurl;
  final String filename;

  ImageData({
    required this.imgurl,
    required this.filename,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imgurl: json['imgurl'] ?? '',
      filename: json['filename'] ?? '',
    );
  }
}