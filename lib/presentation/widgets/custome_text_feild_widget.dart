import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/AppValidation/validator.dart';
import '../../Utils/TextFormFeild/custom_text_form_field.dart';

class CustomeTextFeildWidget {
  static Widget emailField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      keyboardType: TextInputType.emailAddress,
      validator:
          validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $labelText';
            }
            return null;
          },
    );
  }

  static Widget passwordField({
    required TextEditingController controller,
    required RxBool hidePassword,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return Obx(() {
      return CustomTextFormField(
        controller: controller,
        labelText: labelText,
        isPasswordField: true,
        obscureText: hidePassword.value,
        onSuffixIconPressed: () => hidePassword.value = !hidePassword.value,
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $labelText';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
      );
    });
  }

  static Widget phoneField({
    required TextEditingController controller,
    String labelText = 'Phone Number',
    double borderRadius = 14.0,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      keyboardType: TextInputType.phone,
      borderRadius: borderRadius,
      validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
    );
  }

  static Widget customTextField({
    required TextEditingController controller,
    String labelText = 'Full Name',
    String? fieldName = 'Name',
    String? hintText,
    bool obscureText = false,
    bool isPasswordField = false,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool expands = false,
    bool readOnly = false,
    VoidCallback? onTap,
    bool showBorder = true,
    double borderRadius = 14.0,
    Color? customFocusedBorderColor,
    Color? customEnabledBorderColor,
  }) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      validator: (value) => CustomValidator.validateEmptyText(fieldName, value),
      hintText: hintText,
      obscureText: obscureText,
      isPasswordField: isPasswordField,
      suffixIcon: suffixIcon,
      onSuffixIconPressed: onSuffixIconPressed,
      keyboardType: keyboardType,
      maxLines: maxLines,
      expands: expands,
      readOnly: readOnly,
      onTap: onTap,
      showBorder: showBorder,
      borderRadius: borderRadius,
      customFocusedBorderColor: customFocusedBorderColor,
      customEnabledBorderColor: customEnabledBorderColor,
    );
  }

  static Widget searchField({
    required TextEditingController controller,
    String hintText = 'Search...',
    VoidCallback? onSearchPressed,
    double borderRadius = 14.0,
  }) {
    return CustomTextFormField(
      controller: controller,
      labelText: '',
      hintText: hintText,
      suffixIcon: Icons.clear,
      onSuffixIconPressed: () => controller.clear(),
      borderRadius: borderRadius,
    );
  }

  static Widget multiLineField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    int maxLines = 3,
    double borderRadius = 14.0,
  }) {
    return CustomTextFormField(
      controller: controller,
      labelText: labelText,
      validator: validator,
      maxLines: maxLines,
      borderRadius: borderRadius,
    );
  }
}
