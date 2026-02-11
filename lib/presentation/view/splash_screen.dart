import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Constant/images_constant.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/presentation/controller/splash_controller.dart';
import '../../Utils/CircularProgressIndicator/circular_progress_indicator.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ColorResources.getSystemUiOverlayStyle(),
      child: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) => Scaffold(
          body: Stack(
            children: [
              Image.asset(
                ImagesConstant.splashBackgroundImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      color: ColorResources.whiteColor,
                      ImagesConstant.appLogo,
                      height: ContextExtensions(context).isPortrait
                          ? context.responsiveHeight(0.25)
                          : context.responsiveHeight(0.8),
                      width: ContextExtensions(context).isPortrait
                          ? context.responsiveWidth(0.5)
                          : context.responsiveWidth(0.3),
                    ).animate().fadeIn(duration: 800.ms).scaleXY(),
                    const CircularLoaderWidget(
                      strokeWidth: 2,
                      color: ColorResources.whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
