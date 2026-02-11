import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orioconnect/core/contants/storage_keys.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  // User ID (username)
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: StorageKeys.keyUserId, value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: StorageKeys.keyUserId);
  }

  // Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: StorageKeys.keyToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: StorageKeys.keyToken);
  }

  // Employee Code (empno)
  static Future<void> saveEmpNo(String empno) async {
    await _storage.write(key: StorageKeys.keyEmpNo, value: empno);
  }

  static Future<String?> getEmpNo() async {
    return await _storage.read(key: StorageKeys.keyEmpNo);
  }

  // User Name (full_name)
  static Future<void> saveUserName(String name) async {
    await _storage.write(key: StorageKeys.keyUserName, value: name);
  }

  static Future<String?> getUserName() async {
    return await _storage.read(key: StorageKeys.keyUserName);
  }

  // User Email
  static Future<void> saveUserEmail(String email) async {
    await _storage.write(key: StorageKeys.keyUserEmail, value: email);
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(key: StorageKeys.keyUserEmail);
  }

  // User Phone
  static Future<void> saveUserPhone(String phone) async {
    await _storage.write(key: StorageKeys.keyUserPhone, value: phone);
  }

  static Future<String?> getUserPhone() async {
    return await _storage.read(key: StorageKeys.keyUserPhone);
  }

  // Profile Picture
  static Future<void> saveProfilePicture(String imageUrl) async {
    await _storage.write(key: StorageKeys.keyProfilePicture, value: imageUrl);
  }

  static Future<String?> getProfilePicture() async {
    return await _storage.read(key: StorageKeys.keyProfilePicture);
  }

  // User Type (admin, employee, etc.)
  static Future<void> saveUserType(String type) async {
    await _storage.write(key: StorageKeys.keyUserType, value: type);
  }

  static Future<String?> getUserType() async {
    return await _storage.read(key: StorageKeys.keyUserType);
  }

  // Employee ID
  static Future<void> saveEmployeeId(String employeeId) async {
    await _storage.write(key: StorageKeys.keyEmployeeId, value: employeeId);
  }

  static Future<String?> getEmployeeId() async {
    return await _storage.read(key: StorageKeys.keyEmployeeId);
  }

  // Department ID
  static Future<void> saveDepartmentId(String departmentId) async {
    await _storage.write(key: StorageKeys.keyDepartmentId, value: departmentId);
  }

  static Future<String?> getDepartmentId() async {
    return await _storage.read(key: StorageKeys.keyDepartmentId);
  }

  // Designation ID
  static Future<void> saveDesignationId(String designationId) async {
    await _storage.write(key: StorageKeys.keyDesignationId, value: designationId);
  }

  static Future<String?> getDesignationId() async {
    return await _storage.read(key: StorageKeys.keyDesignationId);
  }

  // User Status
  static Future<void> saveUserStatus(String status) async {
    await _storage.write(key: StorageKeys.keyUserStatus, value: status);
  }

  static Future<String?> getUserStatus() async {
    return await _storage.read(key: StorageKeys.keyUserStatus);
  }

  // CNIC
  static Future<void> saveUserCnic(String cnic) async {
    await _storage.write(key: StorageKeys.keyUserCnic, value: cnic);
  }

  static Future<String?> getUserCnic() async {
    return await _storage.read(key: StorageKeys.keyUserCnic);
  }

  // Address
  static Future<void> saveUserAddress(String address) async {
    await _storage.write(key: StorageKeys.keyUserAddress, value: address);
  }

  static Future<String?> getUserAddress() async {
    return await _storage.read(key: StorageKeys.keyUserAddress);
  }

  // DOB
  static Future<void> saveUserDob(String dob) async {
    await _storage.write(key: StorageKeys.keyUserDob, value: dob);
  }

  static Future<String?> getUserDob() async {
    return await _storage.read(key: StorageKeys.keyUserDob);
  }

  // Gender
  static Future<void> saveUserGender(String gender) async {
    await _storage.write(key: StorageKeys.keyUserGender, value: gender);
  }

  static Future<String?> getUserGender() async {
    return await _storage.read(key: StorageKeys.keyUserGender);
  }

  // Join Date
  static Future<void> saveJoinDate(String joinDate) async {
    await _storage.write(key: StorageKeys.keyJoinDate, value: joinDate);
  }

  static Future<String?> getJoinDate() async {
    return await _storage.read(key: StorageKeys.keyJoinDate);
  }

  // Check if logged in (based on token)
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Delete specific key
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}