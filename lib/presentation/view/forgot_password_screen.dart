import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/AppWidgets/app_widget.dart';
import 'package:orioconnect/Utils/Constant/images_constant.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/presentation/controller/forgot_password_controller.dart';
import '../../Utils/Buttons/app_button.dart';
import '../widgets/custome_text_feild_widget.dart';
import '../../Utils/Colors/colors.dart';
import '../../Utils/TextWidget/App_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: context.responsiveHeight(0.01)),
                          AppTextStyle.custom(
                                fontWeight: FontWeight.w500,
                                fontSize: context.responsiveWidth(0.06),
                                context: context,
                                text: 'Forgot Password?',
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
                            text: 'Enter your User ID to reset your password',
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(duration: 1000.ms, delay: 500.ms),
                          SizedBox(height: context.responsiveHeight(0.03)),
                          CustomeTextFeildWidget.emailField(
                            controller: controller.userEmail,
                            labelText: 'User Email',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter user email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.responsiveHeight(0.02)),
                          AppButton(
                            mediaQuery: MediaQuery.of(context),
                            onPressed: () =>
                                controller.forgotPassword(_formKey),
                            isLoading: false,
                            child: AppTextStyle.custom(
                              fontWeight: FontWeight.w400,
                              fontSize: context.responsiveWidth(0.040),
                              color: ColorResources.whiteColor,
                              context: context,
                              text: 'Done',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: context.responsiveHeight(0.02)),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.loginRoute);
                            },
                            child: AppTextStyle.subtitle(
                              color: ColorResources.appMainColor,
                              context: context,
                              text: 'Back to Login',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
