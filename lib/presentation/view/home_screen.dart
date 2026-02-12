import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Constant/images_constant.dart';
import 'package:orioconnect/Utils/Layout/app_layout.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      currentTab: 0,
      isExtend: true,
      showBackButton: false,
      showLogo: false,
      showAppBar: false,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(context),
                _buildMainContent(context),
                _buildAttendanceSummarySection(context),
                SizedBox(height: context.responsiveHeight(0.08)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: context.responsiveHeight(0.28),
      decoration: BoxDecoration(
        color: ColorResources.appMainColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHeight(0.02),
          vertical: context.responsiveWidth(0.02),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profileRoute),
                  child: Row(
                    children: [
                      Container(
                        width: context.responsiveWidth(0.12),
                        height: context.responsiveWidth(0.12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorResources.whiteColor,
                            width: 1.5,
                          ),
                          image: const DecorationImage(
                            image: AssetImage(
                              ImagesConstant.splashBackgroundImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).animate().fadeIn(duration: 800.ms).scale(),
                      SizedBox(width: context.responsiveWidth(0.03)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle.custom(
                                fontSize: context.responsiveWidth(0.040),
                                fontWeight: FontWeight.w500,
                                color: ColorResources.whiteColor,
                                context: context,
                                text: 'Hi, John Doe',
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 200.ms)
                              .slideX(begin: -0.3),
                          SizedBox(height: context.responsiveHeight(0.002)),
                          AppTextStyle.custom(
                                fontSize: context.responsiveWidth(0.035),
                                fontWeight: FontWeight.w400,
                                color: ColorResources.whiteColor,
                                context: context,
                                text: 'Good Morning',
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 400.ms)
                              .slideX(begin: -0.3),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  ImagesConstant.appLogo,
                  color: ColorResources.whiteColor,
                  height: context.responsiveHeight(0.20),
                  width: context.responsiveWidth(0.20),
                ).animate().fadeIn(duration: 800.ms).scaleXY(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      height: context.responsiveHeight(0.45),
      color: ColorResources.whiteColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(context.responsiveHeight(0.15) / 2),
            left: context.responsiveWidth(0.05),
            right: context.responsiveWidth(0.05),
            child:
                Container(
                      decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(context.responsiveWidth(0.03)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextStyle.custom(
                                fontSize: context.responsiveWidth(0.060),
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                context: context,
                                text: '09:30 AM',
                              )
                              .animate()
                              .fadeIn(duration: 1000.ms, delay: 300.ms)
                              .slideY(begin: -0.3, curve: Curves.easeOutBack),
                          AppTextStyle.custom(
                            fontSize: context.responsiveWidth(0.035),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            context: context,
                            text: 'Monday, 12 February 2026',
                          ).animate().fadeIn(duration: 1000.ms, delay: 500.ms),
                          SizedBox(height: context.responsiveHeight(0.01)),
                          _buildCheckInOutButton(context),
                          SizedBox(height: context.responsiveHeight(0.01)),
                          _buildLocationStatus(context),
                          SizedBox(height: context.responsiveHeight(0.02)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTimeInfo(
                                Iconsax.login,
                                '09:00 AM',
                                'Check In',
                                context,
                                0,
                              ),
                              _buildTimeInfo(
                                Iconsax.logout,
                                '--:--',
                                'Check Out',
                                context,
                                1,
                              ),
                              _buildTimeInfo(
                                Iconsax.clock,
                                '00:30',
                                'Working Hours',
                                context,
                                2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 1000.ms, delay: 200.ms)
                    .slideY(begin: 0.5, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInOutButton(BuildContext context) {
    return Opacity(
      opacity: 1.0,
      child: AvatarGlow(
        glowColor: Colors.green,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        glowCount: 2,
        glowRadiusFactor: 0.3,
        child: Material(
          shape: const CircleBorder(),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: context.responsiveWidth(0.50),
              height: context.responsiveWidth(0.50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.login,
                    size: context.responsiveWidth(0.17),
                    color: Colors.white,
                  ),
                  SizedBox(height: context.responsiveHeight(0.005)),
                  AppTextStyle.custom(
                    fontSize: context.responsiveWidth(0.035),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    context: context,
                    text: 'Check In',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationStatus(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.responsiveWidth(0.05)),
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveWidth(0.04),
        vertical: context.responsiveHeight(0.015),
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withAlpha(51), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.tick_circle5,
            size: context.responsiveWidth(0.05),
            color: Colors.green.shade700,
          ),
          SizedBox(width: context.responsiveWidth(0.05)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextStyle.custom(
                  fontSize: context.responsiveWidth(0.032),
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                  context: context,
                  text: 'In Office Range',
                ),
                AppTextStyle.custom(
                  fontSize: context.responsiveWidth(0.028),
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  context: context,
                  text: 'Location verified successfully',
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms, delay: 600.ms);
  }

  Widget _buildTimeInfo(
    IconData icon,
    String time,
    String label,
    BuildContext context,
    int index,
  ) {
    return Column(
          children: [
            Icon(
              icon,
              size: context.responsiveWidth(0.07),
              color: Colors.black,
            ),
            SizedBox(height: context.responsiveHeight(0.01)),
            AppTextStyle.custom(
              fontSize: context.responsiveWidth(0.030),
              fontWeight: FontWeight.w600,
              color: Colors.black,
              context: context,
              text: time,
            ),
            SizedBox(height: context.responsiveHeight(0.005)),
            AppTextStyle.custom(
              fontSize: context.responsiveWidth(0.03),
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.8),
              context: context,
              text: label,
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: (1000 + (index * 100)).ms)
        .slideY(begin: 0.3);
  }

  Widget _buildAttendanceSummarySection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveWidth(0.04)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextStyle.custom(
                    fontSize: context.responsiveWidth(0.035),
                    fontWeight: FontWeight.w400,
                    color: ColorResources.blackColor,
                    context: context,
                    text: 'Attendance Summary',
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 600.ms)
                  .slideX(begin: -0.2),
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.attendanceHistoryListing),
                    icon: Icon(Iconsax.clock, color: ColorResources.blackColor),
                  ).animate().fadeIn(duration: 800.ms, delay: 700.ms).scale(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.calendar_edit,
                      color: ColorResources.blackColor,
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 800.ms).scale(),
                ],
              ),
            ],
          ),
          SizedBox(height: context.responsiveHeight(0.01)),
          _buildAttendanceBoxes(context),
        ],
      ),
    );
  }

  Widget _buildAttendanceBoxes(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: context.responsiveWidth(0.04),
          runSpacing: context.responsiveHeight(0.02),
          children: [
            _buildAttendanceBox(
              "28",
              "Total Days",
              Colors.blueGrey.shade600,
              Colors.blueGrey.shade100,
              context,
              0,
            ),
            _buildAttendanceBox(
              "22",
              "Working Days",
              Colors.blueGrey.shade400,
              Colors.blueGrey.shade100,
              context,
              1,
            ),
            _buildAttendanceBox(
              "20",
              "Present",
              Colors.green.shade600,
              Colors.green.shade100,
              context,
              2,
            ),
            _buildAttendanceBox(
              "1",
              "Casual Leave",
              Colors.purple.shade600,
              Colors.purple.shade100,
              context,
              3,
            ),
            _buildAttendanceBox(
              "1",
              "Annual Leave",
              Colors.blue.shade600,
              Colors.blue.shade100,
              context,
              4,
            ),
            _buildAttendanceBox(
              "0",
              "Sick Leave",
              Colors.orange.shade700,
              Colors.orange.shade100,
              context,
              5,
            ),
          ],
        ),
        SizedBox(height: context.responsiveHeight(0.02)),
      ],
    );
  }

  Widget _buildAttendanceBox(
    String count,
    String label,
    Color backgroundColor,
    Color foregroundColor,
    BuildContext context,
    int index,
  ) {
    return Stack(
          children: [
            Container(
              width: context.responsiveWidth(0.26),
              height: context.responsiveHeight(0.12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Container(
                width: context.responsiveWidth(0.26),
                height: context.responsiveHeight(0.11),
                decoration: BoxDecoration(
                  color: foregroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.responsiveWidth(0.04)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle.custom(
                        fontSize: context.responsiveWidth(0.035),
                        fontWeight: FontWeight.bold,
                        color: backgroundColor,
                        context: context,
                        text: count,
                      ),
                      SizedBox(height: context.responsiveHeight(0.005)),
                      AppTextStyle.custom(
                        fontSize: context.responsiveWidth(0.03),
                        context: context,
                        text: label,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: (900 + (index * 100)).ms)
        .slideY(begin: 0.3)
        .scale(begin: const Offset(0.9, 0.9));
  }
}
