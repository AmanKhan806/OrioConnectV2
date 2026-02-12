import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';
import 'package:orioconnect/data/models/office_wifi_model.dart';

Widget buildWifiCard({
  required BuildContext context,
  required String networkName,
  required String password,
  required RxBool isPasswordVisible,
  VoidCallback? onCopied,
}) {
  return Container(
    padding: EdgeInsets.all(context.responsiveWidth(0.04)),
    decoration: BoxDecoration(
      color: ColorResources.blackColor.withAlpha(7),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.responsiveWidth(0.025)),
              decoration: BoxDecoration(
                color: ColorResources.appMainColor.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Iconsax.wifi,
                size: context.responsiveWidth(0.055),
                color: ColorResources.appMainColor,
              ),
            ),
            SizedBox(width: context.responsiveWidth(0.03)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle.custom(
                    context: context,
                    text: networkName,
                    fontSize: context.responsiveWidth(0.042),
                    fontWeight: FontWeight.w600,
                    color: ColorResources.blackColor,
                  ),
                  SizedBox(height: context.responsiveHeight(0.003)),
                  AppTextStyle.custom(
                    context: context,
                    text: 'Office Network',
                    fontSize: context.responsiveWidth(0.03),
                    fontWeight: FontWeight.w400,
                    color: ColorResources.blackColor.withAlpha(128),
                  ),
                ],
              ),
            ),
            // Connected badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(0.025),
                vertical: context.responsiveHeight(0.005),
              ),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withAlpha(77), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: context.responsiveWidth(0.018),
                    color: Colors.green,
                  ),
                  SizedBox(width: context.responsiveWidth(0.01)),
                  AppTextStyle.custom(
                    context: context,
                    text: 'Active',
                    fontSize: context.responsiveWidth(0.028),
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: context.responsiveHeight(0.015)),
        Divider(color: ColorResources.blackColor.withAlpha(26), height: 1),
        SizedBox(height: context.responsiveHeight(0.012)),

        Row(
          children: [
            Icon(
              Iconsax.lock_1,
              size: context.responsiveWidth(0.04),
              color: ColorResources.blackColor.withAlpha(128),
            ),
            SizedBox(width: context.responsiveWidth(0.02)),
            AppTextStyle.custom(
              context: context,
              text: 'Password',
              fontSize: context.responsiveWidth(0.032),
              fontWeight: FontWeight.w400,
              color: ColorResources.blackColor.withAlpha(153),
            ),
            SizedBox(width: context.responsiveWidth(0.02)),
            Expanded(
              child: Obx(
                () => AppTextStyle.custom(
                  context: context,
                  text: isPasswordVisible.value
                      ? password
                      : '*' * password.length.clamp(6, 12),
                  fontSize: context.responsiveWidth(0.035),
                  fontWeight: FontWeight.w500,
                  color: ColorResources.blackColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Eye toggle button
            Obx(
              () => GestureDetector(
                onTap: () => isPasswordVisible.toggle(),
                child: Container(
                  padding: EdgeInsets.all(context.responsiveWidth(0.015)),
                  child: Icon(
                    isPasswordVisible.value ? Iconsax.eye_slash : Iconsax.eye,
                    size: context.responsiveWidth(0.045),
                    color: ColorResources.appMainColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.responsiveWidth(0.01)),
            // Copy button
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: password));
                onCopied?.call();
                Get.snackbar(
                  '',
                  '',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey[850],
                  borderColor: Colors.grey[700]!,
                  borderWidth: 1,
                  borderRadius: 10,
                  margin: EdgeInsets.all(context.responsiveWidth(0.04)),
                  duration: const Duration(seconds: 2),
                  titleText: const SizedBox.shrink(),
                  messageText: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: ColorResources.whiteColor,
                        size: context.responsiveWidth(0.04),
                      ),
                      SizedBox(width: context.responsiveWidth(0.02)),
                      AppTextStyle.custom(
                        context: context,
                        text: 'Password copied to clipboard',
                        fontSize: context.responsiveWidth(0.032),
                        fontWeight: FontWeight.w400,
                        color: ColorResources.whiteColor,
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(context.responsiveWidth(0.015)),
                decoration: BoxDecoration(
                  color: ColorResources.appMainColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Iconsax.copy,
                  size: context.responsiveWidth(0.04),
                  color: ColorResources.appMainColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class WifiCardItem extends StatelessWidget {
  const WifiCardItem({super.key, required this.wifi});

  final OfficeWifiPayload wifi;

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = false.obs;

    return buildWifiCard(
      context: context,
      networkName: wifi.name ?? 'Unknown Network',
      password: wifi.password ?? '',
      isPasswordVisible: isPasswordVisible,
    );
  }
}
