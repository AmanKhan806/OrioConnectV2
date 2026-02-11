import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/AppWidgets/app_widget.dart';
import 'package:orioconnect/Utils/Buttons/app_button.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Constant/images_constant.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';
import 'package:orioconnect/presentation/controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtpController>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ColorResources.getSystemUiOverlayStyle(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          if (controller.isLoading.value) {
            customSnackBar(
              "Please Wait",
              "Operation in progress. Please wait until it completes.",
              snackBarType: SnackBarType.info,
            );
            return;
          }
          Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: ColorResources.whiteColor,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorResources.appMainColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: context.responsiveHeight(0.05),
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Image.asset(
                          color: ColorResources.whiteColor,
                          ImagesConstant.appLogo,
                          height: context.responsiveHeight(0.24),
                          width: context.responsiveWidth(0.4),
                        ).animate().fadeIn(duration: 800.ms).scaleXY(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: ColorResources.whiteColor),
                  padding: EdgeInsets.all(context.responsiveWidth(0.05)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: context.responsiveHeight(0.01)),
                        AppTextStyle.custom(
                              fontWeight: FontWeight.w500,
                              fontSize: context.responsiveWidth(0.06),
                              context: context,
                              text: 'Enter OTP',
                            )
                            .animate()
                            .fadeIn(duration: 1000.ms, delay: 300.ms)
                            .slideY(
                              begin: -0.4,
                              end: 0.0,
                              curve: Curves.easeOutBack,
                            ),
                        AppTextStyle.subtitle(
                          context: context,
                          text: 'Please enter the verification code',
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 1000.ms, delay: 500.ms),
                        SizedBox(height: context.responsiveHeight(0.03)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Container(
                              width: context.responsiveWidth(0.12),
                              margin: EdgeInsets.symmetric(
                                horizontal: context.responsiveWidth(0.01),
                              ),
                              child: TextField(
                                cursorColor: ColorResources.appMainColor,
                                controller: controller.otpControllers[index],
                                focusNode: controller.focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: TextStyle(
                                  fontSize: context.responsiveWidth(0.05),
                                  fontWeight: FontWeight.normal,
                                  color: ColorResources.blackColor,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ColorResources.greyColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: ColorResources.blackColor
                                          .withAlpha(40),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ColorResources.appMainColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 5) {
                                    FocusScope.of(context).requestFocus(
                                      controller.focusNodes[index + 1],
                                    );
                                  } else if (value.isEmpty && index > 0) {
                                    // Handle backspace - move to previous field
                                    FocusScope.of(context).requestFocus(
                                      controller.focusNodes[index - 1],
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: context.responsiveHeight(0.04)),
                        Obx(
                          () => AppButton(
                            isLoading: controller.isLoading.value,
                            onPressed: controller.verifyOtp,
                            mediaQuery: MediaQuery.of(context),
                            child: AppTextStyle.custom(
                              fontWeight: FontWeight.w400,
                              fontSize: context.responsiveWidth(0.040),
                              color: ColorResources.whiteColor,
                              context: context,
                              text: 'Verify',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: context.responsiveHeight(0.02)),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoutes.loginRoute),
                          child: AppTextStyle.small(
                            color: ColorResources.appMainColor,
                            context: context,
                            text: 'Back to Login?',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Obx(
                          () => controller.errorMessage.value.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: context.responsiveHeight(0.02),
                                  ),
                                  child: Text(
                                    controller.errorMessage.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: context.responsiveWidth(0.03),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).noKeyboard(),
      ),
    );
  }
}
