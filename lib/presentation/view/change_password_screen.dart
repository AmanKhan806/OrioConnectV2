import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/Utils/AppWidgets/app_widget.dart';
import 'package:orioconnect/Utils/Buttons/app_button.dart';
import 'package:orioconnect/Utils/Layout/app_layout.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';
import 'package:orioconnect/presentation/controller/change_password_controller.dart';
import 'package:orioconnect/presentation/widgets/custome_text_feild_widget.dart';
import '../../Utils/Colors/colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePasswordController>();

    return AnnotatedRegion(
      value: ColorResources.getSystemUiOverlayStyle(),
      child: Layout(
        title: "Change Password",
        currentTab: 4,
        showAppBar: true,
        showLogo: true,
        showBackButton: true,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(0.05),
              vertical: context.responsiveHeight(0.03),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextStyle.title(
                  context: context,
                  text: 'Change Your Password',
                  color: ColorResources.blackColor,
                ),
                AppTextStyle.subtitle(
                  context: context,
                  text: 'Enter your current password and create a new one',
                  color: ColorResources.blackColor.withAlpha(100),
                ),
                SizedBox(height: context.responsiveHeight(0.04)),

                // Current Password
                CustomeTextFeildWidget.passwordField(
                  controller: controller.oldPassword,
                  hidePassword: controller.hideOldPassword,
                  labelText: 'Current Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.responsiveHeight(0.02)),

                CustomeTextFeildWidget.passwordField(
                  controller: controller.newPassword,
                  hidePassword: controller.hideNewPassword,
                  labelText: 'New Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.responsiveHeight(0.02)),

                // Confirm Password
                CustomeTextFeildWidget.passwordField(
                  controller: controller.confirmPassword,
                  hidePassword: controller.hideConfirmPassword,
                  labelText: 'Confirm Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.newPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.responsiveHeight(0.04)),

                // Submit Button
                AppButton(
                  mediaQuery: MediaQuery.of(context),
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      controller.changePassword(formkey);
                    }
                  },

                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3.0,
                          strokeCap: StrokeCap.square,
                        )
                      : AppTextStyle.custom(
                          context: context,
                          text: 'Change Password',
                          fontSize: context.responsiveWidth(0.04),
                          fontWeight: FontWeight.w400,
                          color: ColorResources.whiteColor,
                        ),
                ),
              ],
            ),
          ),
        ),
      ).noKeyboard(),
    );
  }
}
