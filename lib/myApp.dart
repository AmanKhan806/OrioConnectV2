import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/bindings/initial_binding.dart';
import 'package:orioconnect/App/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.noScaling,
        boldText: false,
      ),
      child: GetMaterialApp(
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        debugShowMaterialGrid: false,
        checkerboardRasterCacheImages: false,
        checkerboardOffscreenLayers: false,
        title: 'BlueX Attendance',
        initialBinding: InitialBinding(),
        initialRoute: AppPages.initialRoute,
        getPages: AppPages.routes,
        unknownRoute: AppPages.unknownRoute,
      ),
    );
  }
}
