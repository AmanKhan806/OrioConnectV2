class OtpResponseModel {
  final int status;
  final String message;
  final List<PayloadData> payload;

  OtpResponseModel({
    required this.status,
    required this.message,
    required this.payload,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    List<PayloadData> payloadList = [];
    
    if (json['payload'] != null && json['payload'] is List) {
      final payloadData = json['payload'] as List;
      
      for (var item in payloadData) {
        if (item is Map<String, dynamic> && item.isNotEmpty) {
          payloadList.add(PayloadData.fromJson(item));
        }
      }
    }
    
    return OtpResponseModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      payload: payloadList,
    );
  }

  bool get isSuccess => status == 1;
  PayloadData? get userData => payload.isNotEmpty ? payload.first : null;
}

class PayloadData {
  final String token;
  final int id;
  final String username;
  final String email;
  final String type;
  final int employeeId;
  final Employee? employee;
  // final List<Menu> menus;

  PayloadData({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.type,
    required this.employeeId,
    this.employee,
    // required this.menus,
  });

  factory PayloadData.fromJson(Map<String, dynamic> json) {
    // List<Menu> menusList = [];
    // if (json['menus'] != null && json['menus'] is List) {
    //   menusList = (json['menus'] as List)
    //       .map((menu) => Menu.fromJson(menu as Map<String, dynamic>))
    //       .toList();
    // }

    return PayloadData(
      token: json['token']?.toString() ?? '',
      id: json['id'] ?? 0,
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      employeeId: json['employee_id'] ?? 0,
      employee: json['employee'] != null 
          ? Employee.fromJson(json['employee'] as Map<String, dynamic>)
          : null,
      // menus: menusList,
    );
  }
}

class Employee {
  final int id;
  final String employeeCode;
  final String fullName;
  final String? fatherName;
  final String email;
  final String? phone;
  final String? cnic;
  final String? gender;
  final String? dob;
  final String? joinDate;
  final String? leaveDate;
  final int? departmentId;
  final int? designationId;
  final String? profilePicture;
  final String? address;
  final String status;
  final bool isActive;

  Employee({
    required this.id,
    required this.employeeCode,
    required this.fullName,
    this.fatherName,
    required this.email,
    this.phone,
    this.cnic,
    this.gender,
    this.dob,
    this.joinDate,
    this.leaveDate,
    this.departmentId,
    this.designationId,
    this.profilePicture,
    this.address,
    required this.status,
    required this.isActive,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      employeeCode: json['employee_code']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      fatherName: json['father_name']?.toString(),
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
      cnic: json['cnic']?.toString(),
      gender: json['gender']?.toString(),
      dob: json['dob']?.toString(),
      joinDate: json['join_date']?.toString(),
      leaveDate: json['leave_date']?.toString(),
      departmentId: json['department_id'],
      designationId: json['designation_id'],
      profilePicture: json['profile_picture']?.toString(),
      address: json['address']?.toString(),
      status: json['status']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}

// class Menu {
//   final int menuId;
//   final String menuName;
//   final String icon;
//   final int sorting;
//   final String url;
//   final String type;
//   final int? parentId;
//   final String canView;
//   final String canCreate;
//   final String canEdit;
//   final String canDelete;

//   Menu({
//     required this.menuId,
//     required this.menuName,
//     required this.icon,
//     required this.sorting,
//     required this.url,
//     required this.type,
//     this.parentId,
//     required this.canView,
//     required this.canCreate,
//     required this.canEdit,
//     required this.canDelete,
//   });

//   factory Menu.fromJson(Map<String, dynamic> json) {
//     return Menu(
//       menuId: json['menu_id'] ?? 0,
//       menuName: json['menu_name']?.toString() ?? '',
//       icon: json['icon']?.toString() ?? '',
//       sorting: json['sorting'] ?? 0,
//       url: json['url']?.toString() ?? '',
//       type: json['type']?.toString() ?? '',
//       parentId: json['parent_id'],
//       canView: json['can_view']?.toString() ?? '0',
//       canCreate: json['can_create']?.toString() ?? '0',
//       canEdit: json['can_edit']?.toString() ?? '0',
//       canDelete: json['can_delete']?.toString() ?? '0',
//     );
//   }
// }