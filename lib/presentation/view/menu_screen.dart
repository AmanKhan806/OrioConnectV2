import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Layout/app_layout.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';
import 'package:orioconnect/core/storage/secure_storage_service.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Menu",
      showAppBar: true,
      showLogo: true,
      showBackButton: true,
      currentTab: 4,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(0.04),
                  vertical: context.responsiveHeight(0.03),
                ),
                children: [
                  _buildMenuItem(
                    context,
                    icon: Iconsax.wallet_money,
                    title: "Apply Loan",
                    onTap: () {
                      Get.toNamed(AppRoutes.applyLoanRoute);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Iconsax.message_question,
                    title: "Apply Complaint",
                    onTap: () {
                      Get.toNamed(AppRoutes.complaintsRoute);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Iconsax.calendar_edit,
                    title: "Attendance Correction",
                    onTap: () {
                      Get.toNamed(AppRoutes.attendanCorrectionList);
                    },
                  ),
                   _buildMenuItem(
                    context,
                    icon: Iconsax.wifi,
                    title: "Office Wifi",
                    onTap: () {
                      Get.toNamed(AppRoutes.officeWifiRoute);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Iconsax.lock,
                    title: "Change Password",
                    onTap: () {
                      Get.toNamed(AppRoutes.changePasswordRoute);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Iconsax.logout,
                    title: "Logout",
                    isDanger: true,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsiveHeight(0.008)),
      child: Material(
        color: ColorResources.blackColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(0.04),
              vertical: context.responsiveHeight(0.02),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDanger
                      ? Colors.redAccent
                      : ColorResources.appMainColor,
                  size: context.responsiveWidth(0.06),
                ),
                SizedBox(width: context.responsiveWidth(0.04)),
                Expanded(
                  child: AppTextStyle.custom(
                    context: context,
                    text: title,
                    fontSize: context.responsiveWidth(0.03),
                    color: isDanger
                        ? Colors.redAccent
                        : ColorResources.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: context.responsiveWidth(0.04),
                  color: isDanger
                      ? Colors.redAccent.withOpacity(0.6)
                      : ColorResources.blackColor.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorResources.backgroundWhiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Iconsax.logout,
              color: Colors.redAccent,
              size: context.responsiveWidth(0.06),
            ),
            SizedBox(width: context.responsiveWidth(0.03)),
            AppTextStyle.custom(
              context: context,
              text: "Logout Confirmation",
              fontSize: context.responsiveWidth(0.045),
              color: ColorResources.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        content: AppTextStyle.custom(
          context: context,
          text:
              "Are you sure you want to logout? All your session data will be cleared.",
          fontSize: context.responsiveWidth(0.035),
          color: ColorResources.blackColor.withAlpha(120),
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(0.05),
                vertical: context.responsiveHeight(0.015),
              ),
            ),
            child: AppTextStyle.custom(
              context: context,
              text: "Cancel",
              fontSize: context.responsiveWidth(0.035),
              color: ColorResources.appMainColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Logout Button
          TextButton(
            onPressed: () async {
              await SecureStorageService.clearAll();
              Get.offAllNamed(AppRoutes.loginRoute);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(0.05),
                vertical: context.responsiveHeight(0.015),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: AppTextStyle.custom(
              context: context,
              text: "Logout",
              fontSize: context.responsiveWidth(0.035),
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
