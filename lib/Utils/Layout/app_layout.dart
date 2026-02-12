import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Layout extends StatelessWidget {
  final Widget body;
  final int currentTab;
  final bool isExtend;
  final bool showAppBar;
  final bool showLogo;
  final List<Widget> actionButtons;
  final double? appBarHeight;
  final bool showBackButton;
  final String? title;
  final IconData? filterIcon;
  final VoidCallback? onFilterPressed;

  const Layout({
    super.key,
    required this.body,
    this.currentTab = 0,
    this.isExtend = false,
    this.showAppBar = true,
    this.showLogo = true,
    this.actionButtons = const [],
    this.appBarHeight,
    this.showBackButton = false,
    this.title,
    this.filterIcon,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    double defaultAppBarHeight = context.responsiveHeight(0.07);

    return AnnotatedRegion(
      value: ColorResources.getSystemUiOverlayStyle(),
      child: Scaffold(
        extendBodyBehindAppBar: isExtend,
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorResources.whiteColor,
        appBar: showAppBar
            ? PreferredSize(
                preferredSize: Size.fromHeight(
                  appBarHeight ?? defaultAppBarHeight,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(0.04),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorResources.appMainColor,
                        ColorResources.appMainColor.withAlpha(085),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.appMainColor.withAlpha(60),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        if (showBackButton)
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: ColorResources.whiteColor,
                              size: context.responsiveWidth(0.05),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        Expanded(
                          child: Text(
                            title ?? 'App Title',
                            style: TextStyle(
                              color: ColorResources.whiteColor,
                              fontSize: context.responsiveWidth(0.038),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        ...actionButtons,
                        if (filterIcon != null && onFilterPressed != null)
                          IconButton(
                            tooltip: 'Filter',
                            icon: Icon(
                              filterIcon,
                              color: ColorResources.whiteColor,
                              size: context.responsiveWidth(0.055),
                            ),
                            onPressed: onFilterPressed,
                          ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
        body: body,
        bottomNavigationBar: keyboardIsOpened
            ? null
            : LayoutBottomBar(currentTab: currentTab),
      ),
    );
  }
}

class LayoutBottomBar extends StatefulWidget {
  final int currentTab;

  const LayoutBottomBar({super.key, required this.currentTab});

  @override
  State<LayoutBottomBar> createState() => _LayoutBottomBarState();
}

class _LayoutBottomBarState extends State<LayoutBottomBar> {
  void _handleNavigation(int index) {
    if (index == widget.currentTab) return;

    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.homeRoute);
        break;
      case 1:
        Get.toNamed(AppRoutes.homeRoute);
        break;
      case 2:
        Get.toNamed(AppRoutes.homeRoute);
        break;
      case 3:
        Get.toNamed(AppRoutes.homeRoute);
        break;
      case 4:
        Get.toNamed(AppRoutes.menuRoute);
        break;
      default:
        log('Unknown tab index: $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.appMainColor,
        boxShadow: [
          BoxShadow(
            color: ColorResources.appMainColor.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SalomonBottomBar(
        selectedColorOpacity: 0.4,
        itemShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        curve: Curves.easeInOut,
        currentIndex: widget.currentTab,
        onTap: _handleNavigation,
        selectedItemColor: ColorResources.whiteColor,
        unselectedItemColor: ColorResources.whiteColor,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.clock, size: 24),
            title: const Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            selectedColor: ColorResources.whiteColor,
            activeIcon: Icon(
              Iconsax.clock,
              size: 20,
              color: ColorResources.whiteColor,
            ),
          ),

          /// Leave
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.activity, size: 24),
            title: const Text(
              "Leave",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            selectedColor: ColorResources.whiteColor,
            activeIcon: Icon(
              Iconsax.activity,
              size: 20,
              color: ColorResources.whiteColor,
            ),
          ),

          /// Notification
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.money, size: 24),
            title: const Text(
              "Apply Advance",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            selectedColor: ColorResources.whiteColor,
            activeIcon: Icon(
              Iconsax.money,
              size: 20,
              color: ColorResources.whiteColor,
            ),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.user, size: 24),
            title: const Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            selectedColor: ColorResources.whiteColor,
            activeIcon: Icon(
              Iconsax.user,
              size: 20,
              color: ColorResources.whiteColor,
            ),
          ),

          /// Menu
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.menu_1, size: 24),
            title: const Text(
              "Menu",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            selectedColor: ColorResources.whiteColor,
            activeIcon: Icon(
              Iconsax.menu4,
              size: 20,
              color: ColorResources.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
