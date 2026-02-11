class CustomValidator {
  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required';
    }
    return null;
  }
  
  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); 
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email must have @ or .com';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must contain at least one uppercase letter.';
    }
    // if (!value.contains(RegExp(r' [!@#$%^&*(),.?": {}|<>]'))) {
    //   return 'Password must contain at least one speacial character.';
    // }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty){
      return 'Phone number is required.';
    }
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 degits required).';
    }
    return null;
  }
}


class TextValidators {
  static String? validateReason(
    String? value, {
    int minLength = 2,
    int maxLength = 500,
    String fieldName = 'Reason',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    
    final trimmedValue = value.trim();
    
    if (trimmedValue.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    
    if (trimmedValue.length > maxLength) {
      return '$fieldName is too long (max $maxLength characters)';
    }
    
    return null;
  }

  static String? validateComments(String? value) {
    return validateReason(
      value,
      minLength: 2,
      maxLength: 500,
      fieldName: 'Comments',
    );
  }
}