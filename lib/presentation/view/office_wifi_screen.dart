import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orioconnect/Utils/AppWidgets/app_widget.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Layout/app_layout.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';
import 'package:orioconnect/presentation/controller/office_wifi_controller.dart';
import 'package:orioconnect/presentation/view/ScreensWidget/office_wifi_widget.dart';

class OfficeWifiListingScreen extends StatelessWidget {
  const OfficeWifiListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfficeWifiController>();

    return AnnotatedRegion(
      value: ColorResources.getSystemUiOverlayStyle(),
      child: Layout(
        title: "Office WiFi",
        currentTab: 4,
        showAppBar: true,
        showLogo: true,
        showBackButton: true,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.appMainColor,
              ),
            );
          }

          return RefreshIndicator(
            backgroundColor: ColorResources.whiteColor,
            onRefresh: () => controller.fetchOfficeWifiList(),
            color: ColorResources.appMainColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(0.05),
                vertical: context.responsiveHeight(0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle.custom(
                            context: context,
                            text: 'Office WiFi',
                            color: ColorResources.blackColor,
                            fontSize: context.responsiveWidth(0.04),
                            fontWeight: FontWeight.w400,
                          ),
                          AppTextStyle.custom(
                            context: context,
                            text: 'Connect to office networks',
                            color: ColorResources.blackColor,
                            fontSize: context.responsiveWidth(0.03),
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      // Wifi signal icon
                      Container(
                        padding: EdgeInsets.all(context.responsiveWidth(0.02)),
                        decoration: BoxDecoration(
                          color: ColorResources.appMainColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Iconsax.wifi,
                          color: ColorResources.appMainColor,
                          size: context.responsiveWidth(0.055),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.responsiveHeight(0.025)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle.custom(
                        context: context,
                        text: 'Available Networks',
                        fontSize: context.responsiveWidth(0.04),
                        fontWeight: FontWeight.w400,
                        color: ColorResources.blackColor,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveWidth(0.025),
                          vertical: context.responsiveHeight(0.005),
                        ),
                        decoration: BoxDecoration(
                          color: ColorResources.appMainColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AppTextStyle.custom(
                          context: context,
                          text:
                              '${controller.officeWifiList.length} ${controller.officeWifiList.length == 1 ? 'Network' : 'Networks'}',
                          fontSize: context.responsiveWidth(0.03),
                          fontWeight: FontWeight.w500,
                          color: ColorResources.appMainColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.responsiveHeight(0.02)),
                  if (controller.officeWifiList.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.responsiveHeight(0.1),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.wifi_square,
                              size: context.responsiveWidth(0.15),
                              color: ColorResources.blackColor.withAlpha(77),
                            ),
                            SizedBox(height: context.responsiveHeight(0.01)),
                            AppTextStyle.custom(
                              context: context,
                              text: 'No networks found',
                              fontSize: context.responsiveWidth(0.04),
                              fontWeight: FontWeight.w500,
                              color: ColorResources.blackColor.withAlpha(128),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.officeWifiList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.responsiveHeight(0.015)),
                      itemBuilder: (context, index) {
                        final wifi = controller.officeWifiList[index];
                        return WifiCardItem(wifi: wifi);
                      },
                    ),
                ],
              ),
            ),
          );
        }),
      ).noKeyboard(),
    );
  }
}