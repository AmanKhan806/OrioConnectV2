import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:orioconnect/App/bindings/auth_binding.dart';
import 'package:orioconnect/App/bindings/change_password_binding.dart';
import 'package:orioconnect/App/bindings/forgotpassword_binding.dart';
import 'package:orioconnect/App/bindings/office_wifi_binding.dart';
import 'package:orioconnect/App/bindings/otp_binding.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/presentation/view/change_password_screen.dart';
import 'package:orioconnect/presentation/view/error_404_screen.dart';
import 'package:orioconnect/presentation/view/forgot_password_screen.dart';
import 'package:orioconnect/presentation/view/home_screen.dart';
import 'package:orioconnect/presentation/view/login_screen.dart';
import 'package:orioconnect/presentation/view/menu_screen.dart';
import 'package:orioconnect/presentation/view/office_wifi_screen.dart';
import 'package:orioconnect/presentation/view/otp_screen.dart';
import 'package:orioconnect/presentation/view/splash_screen.dart';

class AppPages {
  static const initialRoute = AppRoutes.splashRoute;

  static final routes = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      // binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.loginRoute,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.menuRoute,
      page: () => MenuScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.changePasswordRoute,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.officeWifiRoute,
      page: () => OfficeWifiListingScreen(),
      binding: OfficeWifiBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.otpRoute,
      page: () => const OtpScreen(),
      transition: Transition.leftToRight,
      binding: OtpBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.forgotPasswordRoute,
      page: () => ForgotPasswordScreen(),
      transition: Transition.leftToRight,
      binding: ForgotPasswordBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.error404Route,
      page: () => const Error404View(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];

  static GetPage get unknownRoute => GetPage(
    name: '/not-found',
    page: () => const Error404View(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  );
}
